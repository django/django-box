# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "djangobox-1.10"
  #config.vm.box_url = "https://www.djangoproject.com/m/vms/djangobox-1.10.box"
  config.vm.host_name = "djangobox"
  config.ssh.forward_agent = true

  # Shared folders
  utilize_nfs = (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) == nil
  config.vm.synced_folder "../django", "/django", nfs: utilize_nfs

  # Host-only network required to use NFS shared folders
  config.vm.network :hostonly, "1.2.3.4"
end
