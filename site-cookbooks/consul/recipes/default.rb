#
# Cookbook Name:: consul
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'unzip'

pkg_version = '0.6.0'
work_path = '/tmp'
archive_file = "consul_#{pkg_version}_linux_amd64.zip"
binary_file = 'consul'
deploy_path = '/usr/local/bin'

remote_file "#{work_path}/#{archive_file}" do
  source "https://releases.hashicorp.com/consul/#{pkg_version}/#{archive_file}"
  not_if { File.exist?("#{deploy_path}/#{binary_file}") }
end

execute 'deploy binary' do
  command <<-EOC
    cd #{work_path}
    unzip #{archive_file}
    mv #{binary_file} #{deploy_path}
  EOC
  not_if { File.exist?("#{deploy_path}/#{binary_file}") }
end

directory '/etc/consul.d'
