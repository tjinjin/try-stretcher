#
# Cookbook Name:: serf
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'unzip'

pkg_version = '0.7.0'
work_path = '/tmp'
archive_file = "serf_#{pkg_version}_linux_amd64.zip"
binary_file = 'serf'
deploy_path = '/usr/local/bin'

remote_file "#{work_path}/#{archive_file}" do
  source "https://releases.hashicorp.com/serf/#{pkg_version}/#{archive_file}"
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

remote_file "/etc/systemd/system/serf.service" do
  source "https://raw.githubusercontent.com/hashicorp/serf/master/ops-misc/systemd.conf"
end

service 'serf' do
  action [:enable, :start]
  supports status: true, restart: true
end
