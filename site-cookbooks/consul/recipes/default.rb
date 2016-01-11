#
# Cookbook Name:: consul
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'unzip'

include_recipe 'consul::install'
include_recipe 'consul::setting'
