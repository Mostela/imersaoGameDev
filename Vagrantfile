Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.network "private_network", ip: "192.168.55.10"
  config.vm.network "forwarded_port", guest: 3000, host: 80
  config.vm.synced_folder "./src", "/home/vagrant/game/"
  config.vm.define "mostelagame"
  config.vm.hostname = "mostelagame"
  config.vm.provider "virtualbox" do |vb|
     # Customize the amount of memory on the VM:
     vb.memory = "1024"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "playbook.yml"
    ansible.limit = "all"
    ansible.become = true
    ansible.groups = {
        "maquinaAws" => ["mostelagame"]
    }
  end
end
