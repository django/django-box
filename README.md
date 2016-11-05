django-box: A virtual machine for running the Django core test suite
====================================================================

Forked from djangocore-box (https://github.com/jphalip/djangocore-box)

The django-box is a virtual machine (VM), based on Ubuntu 16.04, containing all
the programs and libraries required for running the Django core test suite in
multiple different environments.

Every supported version of Python is pre-installed, along with all supported
database backends, except for Oracle. Third party libraries like Memcached,
Sphinx, and Pillow are also provided.

This is particularly useful to anybody interested in contributing to Django
core without having to go through the trouble of installing and configuring all
the software required to run the tests in all these environments.

Preparation
-----------

### Software installation

First of all, you need to install the latest versions of
[Vagrant 1.8.5](https://www.vagrantup.com/downloads.html) and
[VirtualBox 5.1.6](https://www.virtualbox.org/wiki/Downloads) on your host
machine.

If you use a version of VirtualBox that isn't 5.1.6 you may run into problems
creating the NFS mount. You can either upgrade to VirtualBox 5.1.6, or you can
try to install the [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
plugin, which will attempt to install your local version of GuestAdditions into
the VM.

```
vagrant plugin install vagrant-vbguest
```

Booting the VM
--------------

_Legend:_ `(host)` is for commands to run on the host machine, and `(vm)` is
for commands to run inside the VM.

Setup the initial directory layout:

    (host) $ cd projects
    (host) $ git clone git@github.com:django/django.git
    (host) $ git clone git@github.com:django/django-box.git

It's important that django is cloned to a directory called `django` directly
beside the `django-box` directory. This is because the virtual machine will
mount `../django/`.

Then, either:

* If you have not already downloaded the box file separately, then run the
  following commands to boot the machine.

        (host) $ cd django-box
        (host) $ vagrant up

  This will automatically download the VM, which is about _1.2GB_ in size (be
  warned if you have a low bandwitdh Internet connection) and then boot it up.
  The download will only occur the first time you run `vagrant up`, as the image
  is saved.

* Or, if you have already downloaded the box file separately, then run the
  following command in order to import the box into vagrant and boot up the VM:

        (host) $ vagrant box add djangoproject/django-box-1.11 path/to/django-box-1.11.box
        (host) $ cd django-box
        (host) $ vagrant up

  `vagrant box add` will copy the box file to `~/.vagrant.d/boxes`, so you may
  delete the file you've dowloaded if you'd like to save some space on your
  hard drive.

  You can download the box file directly from (make sure you update the version
  component):
  https://atlas.hashicorp.com/djangoproject/boxes/django-box-1.11/versions/1.11.2/providers/virtualbox.box

  You can check what the latest released version is here:
  https://atlas.hashicorp.com/djangoproject/boxes/django-box-1.11/

As the VM boots up, it will prompt you to enter your host machine's
administrator password (the same that you use for logging into your host
machine). This is required so that Vagrant can setup the NFS shared folders.

Once the VM is up and running, type the following command to SSH into the VM
(still from inside the `django-box/` folder):

    (host) $ vagrant ssh

Once inside the VM, you can run the tests by typing any of the pre-defined
aliases. For example:

    (vm) $ runtests27-mysql
    (vm) $ runtests34-sqlite3-gis gis_tests
    (vm) $ runtests35-postgres admin_widgets --selenium chrome

Supported commands
------------------

```
runtests27-mysql         runtests27-sqlite3-gis   runtests34-sqlite3       runtests35-postgres-gis  runtests-isort
runtests27-mysql-gis     runtests34-mysql         runtests34-sqlite3-gis   runtests35-sqlite3
runtests27-postgres      runtests34-mysql-gis     runtests35-mysql         runtests35-sqlite3-gis
runtests27-postgres-gis  runtests34-postgres      runtests35-mysql-gis     runtests-docs
runtests27-sqlite3       runtests34-postgres-gis  runtests35-postgres      runtests-flake8
```

Examples
--------

The commands above that target databases all accept arguments and flags
consistent with the unit-tests documentation: https://docs.djangoproject.com/en/dev/internals/contributing/writing-code/unit-tests/
What this means is that you can still run these tests with `--keepdb` to improve
testing performance, and target specific test modules.

```bash
# Run test modules related to expressions
runtests35-postgres --keepdb -v 2 queries expressions lookup aggregation annotations

# Run GIS tests
runtests35-postgres-gis gis_tests

# Run selenium tests against chrome driver (no firefox available yet)
runtests27-sqlite3 admin_widgets --selenium chrome
```


Notes about the VM configuration
--------------------------------

Inside the VM, the `/django` folder is shared with the host and points to the
git clone that was created in the steps above. This way you can edit Django's
code using your favorite editor from your host machine and run the tests from
inside the VM. The repository clone for the django-box itself is also in a
shared folder at `/vagrant`.

The test settings are available in `/home/vagrant/djangodata/test_*.py`. These
files are put onto the `PYTHONPATH` when running the tests.

Chrome is pre-installed so that Django's selenium tests can be run in headless
mode with a virtual display (id `:99`). For example, you may run a specific test
like so:

    (vm) $ runtests27-sqlite3 admin_widgets --selenium chrome

Building the documentation
--------------------------

To build the documentation, change to the docs directory and call a make task:


    (vm) $ cd /django/docs
    (vm) $ make html

You can then view the docs in your browser on the host:

    `(host) $ open django/docs/_build/html/index.html`

Vagrant command tips
--------------------

- To exit the VM and return to your host machine, simple type:

    `(vm) $ exit`

- To shutdown the VM, type:

    `(host) $ vagrant halt`

- To suspend the VM (i.e. freeze the VM's state), type:

    `(host) $ vagrant suspend`

- Once shutdown or suspended, a VM can be restarted with:

    `(host) $ vagrant up`

- To destroy the VM, simply type:

    `(host) $ vagrant destroy`

- To check if the VM is currently running, type:

    `(host) $ vagrant status`

- To re-run the provisioning after the VM has been started (if you have built
  the VM from scratch):

    `(host) $ vagrant provision`

- More information is available in the [Vagrant documentation](https://www.vagrantup.com/docs/).

Building a new version
----------------------

To upgrade or alter the original box, you'll need to recreate it. You'll need to
have Ansible 2.1 or greater installed, and django >= 1.11 in a folder beside the
django-box project as described above. You should also have
the [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin
installed to ensure the correct GuestAdditions are configured within the image.

Make any required changes to the Ansible roles, and then create the box with:

    (host) $ VAGRANT_VAGRANTFILE=Vagrantfile-build vagrant up

The automatic build process will take about 20 minutes. If the new build should
be saved, then you can package the output:

    (host) $ VAGRANT_VAGRANTFILE=Vagrantfile-build vagrant package \
            --output django-box-1.11.box

    (host) $ vagrant box add django-box-1.11.box --name django-box-1.11

Note that compiling a new version should only be required when releasing a new
build to atlas.hashicorp.com.

To upload the new image, logon to the `djangoproject` account on hashicorp atlas
here: https://atlas.hashicorp.com/djangoproject.

- Click through to the box you're updating
- Create a new version, bumping the release version, and adding release notes
- Create a new virtualbox provider for the new version
- Upload the .box file generated from the packaging command above

Credits
-------

django-box was originally authored by [Julien Phalip](https://twitter.com/julienphalip)
and [other contributors](AUTHORS) as djangocore-box.
