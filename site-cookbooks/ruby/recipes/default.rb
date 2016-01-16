#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# site-cookbooks/ruby2/recipes/default.rb
#

%w{readline ncurses gdbm glibc openssl libyaml libffi zlib readline-devel ncurses-devel gdbm-devel glibc-devel gcc openssl-devel make libyaml-devel libffi-devel zlib-devel patch ruby-devel}.each do |pkg|
 package pkg do
 action :install
 end
end

gem_package 'bundler'
