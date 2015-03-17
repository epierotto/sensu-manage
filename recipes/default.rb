#
# Cookbook Name:: sensu-manage
# Recipe:: default
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#


if node["platform_family"] == "windows"
  # do things on windows platforms
  include_recipe "sensu-manage::_windows_checks"
else 
  # do things on linux platforms
  include_recipe "sensu-manage::_linux_checks"
end
