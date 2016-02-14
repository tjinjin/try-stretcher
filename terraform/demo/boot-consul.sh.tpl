#!/bin/sh

systemctl start consul
/usr/local/bin/consul join ${bastion_private_ip}
