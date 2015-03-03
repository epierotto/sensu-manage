# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # Set the version of chef to install using the vagrant-omnibus plugin
  config.omnibus.chef_version = :latest

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  config.berkshelf.berksfile_path = "Berksfile"


  #### Docker1 definition 
  config.vm.define :client do |client|
    client.vm.box = 'opscode-centos-6.6'
    client.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box"
    client.vm.network :private_network, ip: '10.0.0.15'
    client.vm.hostname = 'client'
    config.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id,
                        '--cpus', '1',
                        '--memory', '512',]
        end
    client.vm.provision :chef_solo do |chef|
      chef.data_bags_path = "test/data_bags"
      chef.log_level = :info #:debug
      chef.json = {
        "consul" => {
#          "serve_ui" => true,
          "version" => "0.4.1",
#          "bootstrap_expect" => 2,
          "retry_on_join" => true,
          "bind_interface" => "eth1",
          "advertise_addr" => "10.0.0.15",
          "service_mode" => "client",
          "servers" => ["10.0.0.10","10.0.0.11","10.0.0.12"]
        },
        "sensu" => {
#          "serve_ui" => true,
#          "version" => "0.4.1",
#          "bootstrap_expect" => 1,
#          "retry_on_join" => true,
#          "bind_interface" => "eth1",
#          "advertise_addr" => "10.0.0.10",
          "rabbitmq" => {
		"host" => "rabbitmq.service.consul",
		"port" => "5671",
		
	  },
          "redis" => {
		"host" => "redis.service.consul",
		"port" => "6379"		
	  },
          "servers" => ["10.0.0.10","10.0.0.11","10.0.0.12"]
        },
        "consul-manage" => {
          "service" => {
            "names" => [],
            "data_bag" => ""
          },
	"watch" => {
            "service" => {
                        "names" => [],
                        "data_bag" => ""
                }
          },
          "handlers" => {
                "packages" => ["nc"],
                "sources" => [],
                "dir" => "/usr/local/consul/handlers/"
          }
        }
      }
      chef.run_list = [
        "recipe[yum-epel]",
        "recipe[consul]",
        "recipe[consul-manage::dns]",
        "recipe[consul-manage::handlers]",
        "recipe[sensu-manage::_linux_install]",
	"recipe[sensu::default]"
#	"recipe[sensu::client_service]"
#        "recipe[consul-manage::_define]",
#        "recipe[consul-manage::_watch]",
#        "recipe[docker-manage::_build]",
#        "recipe[docker-manage::_run]"
        ]
    end
  end
end
