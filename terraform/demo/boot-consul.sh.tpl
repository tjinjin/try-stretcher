#!/bin/bash

systemctl start consul
consul join ${bastion_private_ip}
