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

include_recipe 'consul'

git "/tmp/stretcher" do
  user 'vagrant'
  group 'vagrant'
  repository "https://github.com/fujiwara/stretcher.git"
  action :sync
end

execute 'initialize sample' do
  command <<-EOC
    cd /tmp/stretcher/examples
    sed -i 's/^\(consul event\)/#\1/g' prepare.sh
    ./prepare.sh
  EOC
  not_if { File.exist?('/tmp/stretcher/examples/example.tar.gz')}
end
