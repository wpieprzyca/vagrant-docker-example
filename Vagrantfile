VAGRANT_API_VERSION  = "2"

Vagrant.configure(VAGRANT_API_VERSION) do |config|

        config.vm.box = "bento/ubuntu-16.10"

        config.vm.provider "virtualbox" do |vb|
                vb.name = "Developer machine"
                vb.cpus = 4
                vb.memory = 8192
				vb.customize ["modifyvm", :id, "--vram", "128"]
				vb.customize ["modifyvm", :id, "--accelerate3d", "on"]				
				vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]								
				vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "0", "--device", "0", "--nonrotational", "on"]
				vb.gui = true
        end
		
		config.vm.provision "file", source: "eclipse.desktop", destination: "/home/vagrant/Desktop/eclipse.desktop"
		config.vm.provision "file", source: "Dockerfile4Wildfly", destination: "/home/vagrant/Dockerfile4Wildfly"
		config.vm.provision "file", source: "docker-wildfly.service", destination: "/home/vagrant/docker-wildfly.service"
        config.vm.provision "shell", path:"init.sh"		

end

