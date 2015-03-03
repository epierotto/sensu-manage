#
# Cookbook Name:: sensu-manage
# Recipe:: _linux_definitions
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

test = data_bag_item("my_data_bag", "test")

template "/path/to/target/file" do
  source "default.erb"
  variables :test => test
end

template "/file/name.txt" do
  variables :partials => {
    "partial_name_1.txt.erb" => "message",
    "partial_name_2.txt.erb" => "message",
    "partial_name_3.txt.erb" => "message"
  },
end

file "/etc/default/sensu" do
  content <<-eos
EMBEDDED_RUBY=%= node.sensu.use_embedded_ruby %>
LOG_DIR=<%= node.sensu.log_directory %>
LOG_LEVEL=<%= node.sensu.log_level %>
SERVICE_MAX_WAIT=<%= node.sensu.service_max_wait %>

timeout 300;
prepend domain-name-servers 127.0.0.1;
  eos
  notifies :restart, "service[#{service_name}]"
end


file '/etc/default/sensu' do
  content "server=/consul/127.0.0.1##{node[:consul][:ports][:dns]}"
  notifies :reload, "service[dnsmasq]", :immediately
end
