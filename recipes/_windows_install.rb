#
# Cookbook Name:: sensu-manage
# Recipe:: _windows_install
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

source = "#{node['sensu-manage']['windows']['package']['source']}"
package = File.basename(source)
checksum = "#{node['sensu-manage']['windows']['package']['checksum']}"

remote_file "#{Chef::Config[:file_cache_path]}/#{package}" do
  source source
  action :create
  checksum checksum
end


windows_package "#{package}" do
  action :install
  source "#{Chef::Config[:file_cache_path]}/#{package}"
end

# Service Config
admin_user = "#{node['sensu-manage']['windows']['admin_user']}"

service 'sensu-client' do
  action :enable
end


#windows_service 'sensu-client' do
#  run_as_user admin_user
#  action :configure_startup
#  startup_type :automatic
#end
