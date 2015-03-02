#
# Cookbook Name:: sensu-manage
# Recipe:: _windows_definitions
#
# Copyright (C) 2015 Exequiel Pierotto
#
# All rights reserved - Do Not Redistribute
#

case node["platform_family"]
when "windows"
  # do things on debian-ish platforms (debian, ubuntu, linuxmint)
when "debian"
  # do things on debian-ish platforms (debian, ubuntu, linuxmint)
when "rhel"
  # do things on RHEL platforms (redhat, centos, scientific, etc)
end
