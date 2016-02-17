#
# Cookbook Name:: stretcher
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'unzip'

pkg_version = '0.4.1'
work_path = '/tmp'
archive_file = "stretcher-v#{pkg_version}-linux-amd64.zip"
tmp_file = File.basename("#{archive_file}", '.zip')
binary_file = 'stretcher'
deploy_path = '/usr/local/bin'

remote_file "#{work_path}/#{archive_file}" do
  source "https://github.com/fujiwara/stretcher/releases/download/v#{pkg_version}/#{archive_file}"
  not_if { File.exist?("#{deploy_path}/#{binary_file}") }
end

execute 'deploy binary' do
  command <<-EOC
    cd #{work_path}
    unzip #{archive_file}
    mv #{tmp_file} #{deploy_path}/#{binary_file}
    chmod 755 #{deploy_path}/#{binary_file}
  EOC
  not_if { File.exist?("#{deploy_path}/#{binary_file}") }
end

%w(
  /var/tmp/chef
  /var/tmp/chef/releases
).each do |dir|
  directory dir
end
