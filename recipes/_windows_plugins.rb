# Cookbook Name:: sensu-manage
# Recipe:: _windows_plugins
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

# Create a directory to store the scripts

admin_user = "#{node['sensu-manage']['windows']['admin_user']}"
plugins_dir = "#{node['sensu-manage']['windows']['plugins']['dir']}"
gem_binary = 'C:\opt\sensu\embedded\bin\gem.bat'

directory plugins_dir do
  rights :read, admin_user
  rights :full_control, admin_user
  action :create
  recursive true
  not_if { Dir.exist? ("#{plugins_dir}") }
end

# Read data_bag to retrieve plugins info
data_bags = node['sensu-manage']['checks']['data_bags']

data_bags.keys.each do |data_bag|

  data_bags[data_bag].keys.each do |item|

    # Load plugin config from data_bag item
    bag = data_bag_item(data_bag,item)
    
    if bag.key?('plugins')
      plugins = bag['plugins']

      if plugins.key?('rubygems')
        # Install the needed gem packages from a designated repo
        if plugins['rubygems']['repo'].empty?
          plugins['rubygems']['gems'].each do |gem|
            
            gem_package gem do
              gem_binary gem_binary
              action :install
              ignore_failure true
            end

          end

        else

          plugins['rubygems']['gems'].each do |gem|

            gem_package gem do
              gem_binary gem_binary
              source "#{plugins['rubygems']['repo']}"
              action :install
              ignore_failure true
            end

          end

        end

      end
      # Copy the scripts into the plugins directory
      unless plugins['sources'].empty?
        plugins_sources = plugins['sources']

        plugins_sources.each do |source|
          plugin_script = File.basename(source)
          remote_file "#{plugins_dir}/#{plugin_script}" do
            action :create
            source source
            rights :read, admin_user
            rights :full_control, admin_user
            backup false
          end
        end

        end

      end

    end
    
end

