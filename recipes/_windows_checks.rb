#
# Cookbook Name:: sensu-manage
# Recipe:: _windows_checks
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

require 'json'

admin_user = "#{node['sensu-manage']['windows']['admin_user']}"
sensu_dir = "#{node['sensu-manage']['windows']['directory']}"
data_bags = node['sensu-manage']['checks']['data_bags']

data_bags.keys.each do |data_bag|

  data_bags[data_bag].keys.each do |item|

    # Load check config from data_bag item
    bag = data_bag_item(data_bag,item)  
    check = { 'checks' => bag['checks'] }

    if data_bags[data_bag].key?(item)
      # Override check configuration if necessary with check attributes
      unless data_bags[data_bag][item].empty?
        
        data_bags[data_bag][item].each do |key,value|
  
          check['checks'][item][key] = value
  
        end
  
      end
    end
    # Dump the json check
    file "#{sensu_dir}/conf.d/#{item}.json" do
      rights :read, admin_user
      rights :full_control, admin_user 
      content JSON.pretty_generate(check)
      notifies :restart, 'service[sensu-client]'
    end
  end
end
