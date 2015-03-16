# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # Set the version of chef to install using the vagrant-omnibus plugin
  config.omnibus.chef_version = :latest

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  config.berkshelf.berksfile_path = "Berksfile"


  #### Client definition 
  config.vm.define :client32 do |client32|
    client32.vm.box = 'opscode-centos-6.6'
    client32.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box"
    client32.vm.network :private_network, ip: '10.0.0.15'
    client32.vm.hostname = 'client32'
    config.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id,
                        '--cpus', '1',
                        '--memory', '512',]
        end
    client32.vm.provision :chef_solo do |chef|
      chef.data_bags_path = "test/data_bags"
      chef.log_level = :info #:debug
      chef.json = {
        "consul" => {
          "version" => "0.4.1",
          "retry_on_join" => true,
          "bind_interface" => "eth1",
          "advertise_addr" => "10.0.0.15",
          "service_mode" => "client",
          "servers" => ["10.0.0.10","10.0.0.11","10.0.0.12"]
        },
        "sensu-manage" => {
	  "linux" =>{
            "admin_user" => "root",
            "user" => "sensu",
            "group" => "sensu",
            "directory" => "/etc/sensu",
            "log_directory" => "/var/log/sensu",
            "log_level" => "info",
            "service_max_wait" => 10,
            "use_embedded_ruby" => true,
            "plugins" => {
	      "dir" => "/opt/sensu/plugins"
	    },
            "package" => {
	      "source" => "http://repos.sensuapp.org/yum/el/6/x86_64/sensu-0.16.0-1.x86_64.rpm",
	      "version" => "0.16.0",
	      "checksum" => "1df8fccb861adea9723f49392a393ab6a557e70c3515f7b45f3faf689f3e2b53"
	    }
	  },
          "windows" => {
		"admin_user" => "Administrator",
		"directory" => "C:/etc/sensu",
		"log_directory" => "C:/var/log/sensu",
		"package" => {
			"source" => "http://repos.sensuapp.org/msi/sensu-0.12.3-1.msi",
			"checksum" => "1df8fccb861adea9723f49392a393ab6a557e70c3515f7b45f3faf689f3e2b53"
		},
		"plugins" => {
			"dir" => "C:/opt/sensu/plugins"
		},
	  },
          "rabbitmq" => {
		"host" => "rabbitmq.service.consul",
		"port" => "5671",
		"vhost" => "/sensu",
		"user" => "sensu",
		"password" => "sensu"
		
	  },
          "ssl" => {
		"data_bag" => "sensu",
		"ssl_item" => "ssl"		
	  },
          "checks" => {
		"data_bags" => {
			"sensu_checks" => {
			       "check-consul_service" => {
					"command" => "nc -zv 10.0.0.10 4000",
					"interval" => 10,
					"type" => "metric"
				 }
			}
		}
	  }
        }
      }
      chef.run_list = [
        "recipe[yum-epel]",
        "recipe[consul]",
        "recipe[consul-manage::dns]",
  #      "recipe[consul-manage::handlers]",
        "recipe[sensu-manage::_linux_install]",
        "recipe[sensu-manage::_linux_checks]",
        "recipe[sensu-manage::_linux_plugins]",
#	"recipe[sensu::default]"
#	"recipe[sensu::client_service]"
#        "recipe[consul-manage::_define]",
#        "recipe[consul-manage::_watch]",
#        "recipe[docker-manage::_build]",
#        "recipe[docker-manage::_run]"
        ]
    end
  end
end
