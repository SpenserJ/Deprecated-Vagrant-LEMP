# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :hostonly, "33.33.33.10"
  # config.vm.network :bridged

  config.vm.forward_port 80, 8080
  config.vm.forward_port 8000, 8000
  config.vm.forward_port 3306, 3306

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  config.vm.share_folder "www-data", "/var/www/", "www/", :create => true

  config.vm.customize do |vm|
    vm.memory_size = 256
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("vagrant_main")

    chef.json.merge!(JSON.parse(File.read("chef-solo.json")))
  end
end
