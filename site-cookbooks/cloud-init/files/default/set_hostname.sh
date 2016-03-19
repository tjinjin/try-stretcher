#!/bin/bash

export AWS_DEFAULT_REGION=ap-northeast-1
jq=/usr/local/bin/jq

instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
json=$($aws ec2 describe-instances --instance-ids $instance_id)
private_ip_address=$(echo $json | $jq -r '.Reservations[0].Instances[0].PrivateIpAddress' | tr "." "-")
role_tag=$(echo $json | $jq -r '.Reservations[].Instances[].Tags[] | select(.Key=="Role").Value')
group_tag=$(echo $json | $jq -r '.Reservations[].Instances[].Tags[] | select(.Key=="aws:autoscaling:groupName").Value')

#set hostname
hostnamectl set-hostname $group_tag-$role_tag-$private_ip_address
