#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'change-timezone' do
  command <<-EOC
    sudo timedatectl set-timezone Asia/Tokyo
  EOC
  not_if "timedatectl | grep JST"
end
