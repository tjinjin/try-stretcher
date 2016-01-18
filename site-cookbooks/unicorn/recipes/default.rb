#
# Cookbook Name:: unicorn
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
template '/etc/systemd/system/unicorn.service' do
  variables(
    rails_env: node['unicorn']['rails_env']
  )
  notifies :run, 'execute[systemd-daemon-reload]', :immediately
end

execute 'systemd-daemon-reload' do
  command <<-EOC
    systemctl daemon-reload
  EOC
  action :nothing
end

service 'unicorn' do
  action [:enable]
end
