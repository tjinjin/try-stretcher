#
# Cookbook Name:: rails
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'user'

%w(/var /var/www /var/www/shared /var/www/shared/log /var/www/shared/pids /var/www/shared/data /var/www/releases).each do |dir|
  directory dir  do
    mode '0755'
    owner 'app'
    group 'app'
  end
end

package 'gcc-c++'

# use sqlite
package 'sqlite-devel'
