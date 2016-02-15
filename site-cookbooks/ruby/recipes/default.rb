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
package 'libyaml'

ruby_rpm_path = '/var/tmp/ruby-2.2.3-1.el7.centos.x86_64.rpm'

remote_file ruby_rpm_path do
   source 'https://github.com/feedforce/ruby-rpm/releases/download/2.2.3/ruby-2.2.3-1.el7.centos.x86_64.rpm'
end

rpm_package 'ruby' do
  source ruby_rpm_path
end

gem_package 'bundler'
