#
# Cookbook Name:: stretcher
# Recipe:: example
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'git'
package 'golang'

git "/tmp/stretcher" do
  user 'vagrant'
  group 'vagrant'
  repository "https://github.com/fujiwara/stretcher.git"
  action :sync
end
