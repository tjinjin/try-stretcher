#!/bin/sh

systemctl start consul
sleep 10
/usr/local/bin/consul join ${bastion_private_ip}
