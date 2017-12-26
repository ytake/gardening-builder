# -*- mode: ruby -*-
# vi: set ft=ruby :

Encoding.default_external = 'UTF-8'

VAGRANTFILE_API_VERSION = "2"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.box = "bento/centos-7.4"
  config.vm.box_version = ">= 0"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end
  # Don't Replace The Default Key https://github.com/mitchellh/vagrant/pull/4707
  config.ssh.insert_key = false

  config.vm.provision 'shell', path: './provision/update.sh'
  config.vm.provision 'shell', path: './provision/nodejs.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './provision/database.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './provision/mssql.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './provision/document_database.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './provision/php.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './provision/servers.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './provision/apache_foundation.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './provision/local.sh'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './provision/end.sh'
end
