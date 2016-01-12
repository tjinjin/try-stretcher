#
# Cookbook Name:: deploy
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe 'consul'
include_recipe 'stretcher'

package 'git'
package 'golang'

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
