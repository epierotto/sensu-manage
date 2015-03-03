#
# Cookbook Name:: sensu-manage
# Recipe:: _linux_install
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

source = "#{node['sensu-manage']['linux']['package']['source']}"
package = File.basename(source)
version = "#{node['sensu-manage']['linux']['package']['version']}"
checksum = "#{node['sensu-manage']['linux']['package']['checksum']}"
package_options = "#{node['sensu-manage']['linux']['package']['options']}"

remote_file "#{Chef::Config[:file_cache_path]}/#{package}" do
  source source
  action :create
  checksum checksum
end

package "#{package}" do
  action :install
  source "#{Chef::Config[:file_cache_path]}/#{package}"
  version version
  options package_options
end

service 'sensu-client' do
  action :enable
end
