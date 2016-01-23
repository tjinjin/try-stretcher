#!/bin/bash

yum install -y httpd
systemctl start httpd

COLOR="blue"
INSTANCE_ID=$(cat /var/lib/cloud/data/instance-id)

echo "Hello world" | tee /var/www/html/index.html
echo "Instance ID: ${INSTANCE_ID}" | tee -a /var/www/html/index.html
echo "Color: ${COLOR}" | tee -a /var/www/html/index.html
