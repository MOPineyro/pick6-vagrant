Vagrant.configure('2') do |config|
  config.vm.box = 'chef/ubuntu-14.04'
  config.omnibus.chef_version = :latest

  config.vm.network :private_network, type: 'dhcp'
  # Rails Port Forward
  config.vm.network :forwarded_port, guest: 3000, host: 3100
  # Ember Port Forward
  # config.vm.network :forwarded_port, guest: 4000, host: 4100
  config.vm.synced_folder './code', '/home/vagrant/code', nfs: true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ['chef/cookbooks']
    chef.add_recipe 'recipe[cocoon]'
  end
end
