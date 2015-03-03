#
# Cookbook Name:: sensu-manage
# Recipe:: _linux_plugins
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#


# Install the needed packages

packages = node['consul-manage']['handlers']['packages']

packages.each do |item|
  package item do
    action :install
  end
end


# Create a directory to store the scripts

handlers_dir = "#{node['consul-manage']['handlers']['dir']}"

directory handlers_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
  not_if { Dir.exist? ("#{handlers_dir}") }
end


# Copy the files into the handlers directory

handlers_sources = node['consul-manage']['handlers']['sources']

handlers_sources.each do |source|

  handler_script = File.basename(source)

  remote_file "#{handlers_dir}/#{handler_script}" do
    action :create_if_missing
    source source
    mode "0755"
    backup false
  end

end
