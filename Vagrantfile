Vagrant::Config.run do |config|
  config.vm.box = "lucid32"

  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  config.vm.forward_port 3000, 3000

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests/"
    puppet.module_path = "puppet/modules"
  end

  config.vm.customize ["modifyvm", :id, "--memory", 2048]
  config.vm.customize ["modifyvm", :id, "--cpus", 2]
end
