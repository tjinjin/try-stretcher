#
# Cookbook Name:: awscli
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
easy_install_package 'pip'

execute 'install-awscli' do
    command 'pip install awscli'
      not_if "pip show awscli > /dev/null"
end
