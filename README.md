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
[Vagrant](https://www.vagrantup.com/downloads.html) and
[VirtualBox](https://www.virtualbox.org/wiki/Downloads) on your host machine.

Booting the VM
--------------

_Legend:_ `(host)` is for commands to run on the host machine, and `(vm)` is
for commands to run inside the VM.

Setup the initial directory layout:

    (host) $ cd projects
    (host) $ git clone git@github.com:django/django.git
    (host) $ git clone git@github.com:django/django-box.git

Then, either:

* If you have not already downloaded the box file separately, then run the
  following commands to boot the machine.

        (host) $ cd django-box
        (host) $ vagrant up

  This will automatically download the VM, which is about _1.5GB_ in size (be
  warned if you have a low bandwitdh Internet connection) and then boot it up.
  The download will only occur the first time you run `vagrant up`, as the image
  is saved.

* Or, if you have already downloaded the box file separately, then run the
  following command in order to import the box into vagrant and boot up the VM:

        (host) $ vagrant box add django-box-1.10 path/to/django-box-1.10.box
        (host) $ cd django-box
        (host) $ vagrant up

  `vagrant box add` will copy the box file to `~/.vagrant.d/boxes`, so you may
  delete the file you've dowloaded if you'd like to save some space on your
  hard drive.

As the VM boots up, it will prompt you to enter your host machine's
administrator password (the same that you use for logging into your host
machine). This is required so that Vagrant can setup the NFS shared folders.

Once the VM is up and running, type the following command to SSH into the VM
(still from inside the `django-box/` folder):

    (host) $ vagrant ssh

Once inside the VM, you can run the tests by typing any of the pre-defined
aliases. For example:

    (vm) $ runtests2.7-mysql
    (vm) $ runtests3.4-spatialite gis_tests
    (vm) $ runtests3.5-postgresql admin_widgets --selenium chrome,firefox

Supported commands
------------------

```
runtests2.7-mysql          runtests3.4-mysql          runtests3.5-mysql
runtests2.7-mysql_gis      runtests3.4-mysql_gis      runtests3.5-mysql_gis
runtests2.7-postgis        runtests3.4-postgis        runtests3.5-postgis
runtests2.7-postgres       runtests3.4-postgres       runtests3.5-postgres
runtests2.7-spatialite     runtests3.4-spatialite     runtests3.5-spatialite
runtests2.7-sqlite3        runtests3.4-sqlite3        runtests3.5-sqlite3
```

Building a new version
----------------------

To upgrade or alter the original box, you'll need to recreate it. You'll need to
have Ansible 2.1 or greater installed, and django in a folder beside the
django-box project as described above.

Make any required changes to the Ansible roles, and then create the box with:

```
VAGRANT_VAGRANTFILE=Vagrantfile-build vagrant up
```

The automatic build process will take about an hour. If the new build should be
saved, then you can package the output:

```
VAGRANT_VAGRANTFILE=Vagrantfile-build vagrant package \
    --output django-box-DJANGO-VERSION.box

vagrant box add django-box-DJANGO-VERSION.box --name django-box-DJANGO-VERSION
```

Notes about the VM configuration
--------------------------------

Inside the VM, the `/django` folder is shared with the host and points to the
git clone that was created in the steps above. This way you can edit Django's
code using your favorite editor from your host machine and run the tests from
inside the VM. The repository clone for the django-box itself is also in a
shared folder at `/vagrant`.

`virtualenvwrapper` is installed so you may run, for example:

    (vm) $ workon py3.5

The test settings are available in `/home/vagrant/djangodata/test_*.py`. These
files are available to each virtualenv via symlinks.

Chrome is pre-installed so that Django's selenium tests can be run in headless
mode in a virtual display (with the id `:99`). For example, you may run a
specific test like so:

    (vm) $ runtests2.7-sqlite3 admin_widgets --selenium chrome

Building the documentation
--------------------------

To build the documentation, simply activate one of the virtualenvs and run the
Sphinx build command:

    workon py2.7
    cd /django/docs
    make html

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

Credits
-------

django-box was originally authored by [Julien Phalip](https://twitter.com/julienphalip)
and [other contributors](AUTHORS) as djangocore-box.
