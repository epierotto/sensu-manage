#
# Cookbook Name:: sensu-manage
# Recipe:: _linux_install
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

# Install
source = "#{node['sensu-manage']['linux']['package']['source']}"
package = File.basename(source)
version = "#{node['sensu-manage']['linux']['package']['version']}"
checksum = "#{node['sensu-manage']['linux']['package']['checksum']}"
package_options = "#{node['sensu-manage']['linux']['package']['options']}"

remote_file "#{Chef::Config[:file_cache_path]}/#{package}" do
  source source
  action :create
  checksum checksum
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/#{package}") }
end

package "sensu" do
  action :install
  source "#{Chef::Config[:file_cache_path]}/#{package}"
  version version
  options package_options
end

# Client Config
admin_user = "#{node['sensu-manage']['linux']['admin_user']}"
sensu_user = "#{node['sensu-manage']['linux']['user']}"
sensu_group = "#{node['sensu-manage']['linux']['group']}"

template "/etc/default/sensu" do
  source "sensu.default.erb"
  notifies :restart, 'service[sensu-client]'#, :immediately
end

# SSL/TSL
ssl_data_bag = "#{node['sensu-manage']['ssl']['data_bag']}"
ssl_item = "#{node['sensu-manage']['ssl']['ssl_item']}"
sensu_dir = "#{node['sensu-manage']['linux']['directory']}"

  directory "#{sensu_dir}/ssl" do
    owner admin_user
    group sensu_group
    mode 0754
    recursive true
    action :create
  end

  ssl = data_bag_item( ssl_data_bag, ssl_item)

  file "#{sensu_dir}/ssl/cert.pem" do
    content ssl["client"]["cert"]
    owner admin_user
    group sensu_group
    mode 0640
    notifies :restart, 'service[sensu-client]'
  end

  file "#{sensu_dir}/ssl/key.pem" do
    content ssl["client"]["key"]
    owner admin_user
    group sensu_group
    mode 0640
    notifies :restart, 'service[sensu-client]'
  end


template "#{sensu_dir}/config.json" do
  source "sensu.client.erb"
  mode '0644'
  owner admin_user
  group sensu_group
  variables({
     :ssl_cert_chain_file => "#{sensu_dir}/ssl/cert.pem",
     :ssl_private_key_file => "#{sensu_dir}/ssl/key.pem",
     :subscriptions => node["roles"] + ["all"]
  })
  notifies :restart, 'service[sensu-client]'
end


service 'sensu-client' do
  action :enable 
end
