# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "djangoproject/django-box-1.11"
  config.vm.host_name = "djangobox"
  config.ssh.forward_agent = true

  # Shared folders
  utilize_nfs = (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) == nil
  config.vm.synced_folder "../django", "/django", nfs: utilize_nfs

  # Host-only network required to use NFS shared folders
  config.vm.network "private_network", ip: "1.2.3.4"
end
