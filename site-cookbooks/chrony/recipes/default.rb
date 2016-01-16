#
# Cookbook Name:: chrony
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'chrony'

service 'chronyd' do
  supports start: true, status: true, reload: true
  action [:enable, :start]
end
