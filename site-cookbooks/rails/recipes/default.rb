#
# Cookbook Name:: rails
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'user'

app_name = node[:rails][:app_name]

%W(/var/www /var/www/#{app_name} /var/www/#{app_name}/shared /var/www/#{app_name}/shared/log /var/www/#{app_name}/shared/pids /var/www/#{app_name}/shared/data /var/www/#{app_name}/releases).each do |dir|
  directory dir  do
    mode '0755'
    owner 'app'
    group 'app'
  end
end

package 'gcc-c++'

# use sqlite
package 'sqlite-devel'
