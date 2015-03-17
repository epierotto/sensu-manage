#
# Cookbook Name:: sensu-manage
# Recipe:: _windows_install
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

# Client install
admin_user = "#{node['sensu-manage']['windows']['admin_user']}"
source = "#{node['sensu-manage']['windows']['package']['source']}"
package = File.basename(source)
checksum = "#{node['sensu-manage']['windows']['package']['checksum']}"
dism_source = "#{node['sensu-manage']['windows']['dism_source']}"

remote_file "#{Chef::Config[:file_cache_path]}/#{package}" do
  source source
  rights :read, admin_user
  rights :full_control, admin_user
  action :create
  checksum checksum
end

if win_version.windows_server_2012? || win_version.windows_server_2012_r2?
  windows_feature "NetFx3ServerFeatures" do
    #source dism_source
  end
end

windows_feature "NetFx3" do
  #source dism_source
end

windows_package "Sensu" do
  action :install
  source "#{Chef::Config[:file_cache_path]}/#{package}"
end


# Client Config
sensu_dir = "#{node['sensu-manage']['windows']['directory']}"
sensu_log_dir = "#{node['sensu-manage']['windows']['log_directory']}"

template 'C:\opt\sensu\bin\sensu-client.xml' do
  source "sensu.xml.erb"
  rights :read, admin_user
  rights :full_control, admin_user
  variables({
     :service => "sensu-client", 
     :name => "Sensu Client",
     :sensu_dir => "#{sensu_dir}",
     :sensu_log_dir => "#{sensu_log_dir}"
  })
  notifies :restart, 'service[sensu-client]'
end


# SSL/TSL
ssl_data_bag = "#{node['sensu-manage']['ssl']['data_bag']}"
ssl_item = "#{node['sensu-manage']['ssl']['ssl_item']}"

  directory "#{sensu_dir}/ssl" do
    recursive true
    action :create
  end

  ssl = data_bag_item( ssl_data_bag, ssl_item)

  file "#{sensu_dir}/ssl/cert.pem" do
    content ssl["client"]["cert"]
    rights :read, admin_user
    rights :full_control, admin_user
    notifies :restart, 'service[sensu-client]'
  end

  file "#{sensu_dir}/ssl/key.pem" do
    content ssl["client"]["key"]
    rights :read, admin_user
    rights :full_control, admin_user
    notifies :restart, 'service[sensu-client]'
  end

template "#{sensu_dir}/config.json" do
  source "sensu.client.erb"
  rights :read, admin_user
  rights :full_control, admin_user
  variables({
     :ssl_cert_chain_file => "#{sensu_dir}/ssl/cert.pem",
     :ssl_private_key_file => "#{sensu_dir}/ssl/key.pem",
     :subscriptions => node["roles"] + ["all"]
  })
  notifies :restart, 'service[sensu-client]'
end


# Service Config
execute "sensu-client.exe install" do
  cwd 'C:\opt\sensu\bin'
  not_if {
    ::Win32::Service.exists?("sensu-client")
  }
end

service "sensu-client" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
