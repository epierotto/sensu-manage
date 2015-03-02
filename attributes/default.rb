#
# Cookbook Name:: sensu-manage
# Attributes:: default
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

# Attributes for installing sensu client
default['sensu-manage']['linux']['plugins']['packages'] = []
default['sensu-manage']['linux']['plugins']['sources'] = []
default['sensu-manage']['linux']['plugins']['dir'] = ""

default['sensu-manage']['windows']['plugins']['packages'] = []
default['sensu-manage']['windows']['plugins']['sources'] = []
default['sensu-manage']['windows']['plugins']['dir'] = ""

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

