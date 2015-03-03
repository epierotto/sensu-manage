#
# Cookbook Name:: sensu-manage
# Attributes:: default
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

default['sensu-manage']['windows']['admin_user'] = "Administrator"
default['sensu-manage']['windows']['directory'] = 'C:\etc\sensu'
default['sensu-manage']['windows']['log_directory'] = 'C:\var\log\sensu'


default['sensu-manage']['linux']['admin_user'] = "root"
default['sensu-manage']['linux']['user'] = "sensu"
default['sensu-manage']['linux']['group'] = "sensu"
default['sensu-manage']['linux']['directory'] = "/etc/sensu"
default['sensu-manage']['linux']['log_directory'] = "/var/log/sensu"

# SSL config
default['sensu-manage']['ssl']['data_bag'] = "sensu"
default['sensu-manage']['ssl']['ssl_item'] = "ssl"
default['sensu-manage']['ssl']['data_bag.config_item'] = "config"

# Rabbitmq config
default['sensu-manage']['rabbitmq']['host'] = "rabbitmq.service.consul"
default['sensu-manage']['rabbitmq']['port'] = 5671
default['sensu-manage']['rabbitmq']['vhost'] = "/sensu"
default['sensu-manage']['rabbitmq']['user'] = "sensu"
default['sensu-manage']['rabbitmq']['password'] = "sensu"

# Attributes for installing sensu client
default['sensu-manage']['linux']['package']['source'] = "http://repos.sensuapp.org/yum/el/6/x86_64/sensu-0.16.0-1.x86_64.rpm"
default['sensu-manage']['linux']['package']['version'] = "0.16.0"
default['sensu-manage']['linux']['package']['checksum'] = "1df8fccb861adea9723f49392a393ab6a557e70c3515f7b45f3faf689f3e2b53"
default['sensu-manage']['linux']['package']['options'] = ""

default['sensu-manage']['windows']['package']['source'] = "http://repos.sensuapp.org/msi/sensu-0.12.3-1.msi"
default['sensu-manage']['windows']['package']['checksum'] = "1df8fccb861adea9723f49392a393ab6a557e70c3515f7b45f3faf689f3e2b53"


default['sensu-manage']['linux']['config']['use_embedded_ruby'] = false
default['sensu-manage']['linux']['config']['use_embedded_ruby'] = false

default['sensu-manage']['container']['names'] = ["redis"]
default['sensu-manage']['container']['data_bag'] = "docker_containers"

# Attributes for setting up a consul event watch
default['sensu-manage']['watch']['event']['names'] = []
default['sensu-manage']['watch']['event']['data_bag'] = ""

# Attributes for setting up a consul service  watch
default['sensu-manage']['watch']['service']['names'] = []
default['sensu-manage']['watch']['service']['data_bag'] = ""

# Attributes for deploying the sensu plugin scripts
default['sensu-manage']['linux']['plugins']['packages'] = []
default['sensu-manage']['linux']['plugins']['sources'] = []
default['sensu-manage']['linux']['plugins']['dir'] = ""

default['sensu-manage']['windows']['plugins']['packages'] = []
default['sensu-manage']['windows']['plugins']['sources'] = []
default['sensu-manage']['windows']['plugins']['dir'] = ""

