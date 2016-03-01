#!/bin/sh

systemctl start consul

###
#
# deploy tasks
#
###
# for stretcher
export AWS_DEFAULT_REGION=ap-northeast-1
# chef
echo 's3://tjinjin-server-stretcher/manifests/manifest_bastion_development.yml' | stretcher
