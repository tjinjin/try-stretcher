#!/bin/sh

cat << EOF >/etc/consul.d/server.json
{
  "server": true,
  "client_addr": "0.0.0.0",
  "bootstrap_expect": 3,
  "data_dir": "/tmp/consul",
  "start_join": ["${bastion_private_ip}"],
  "watches": [
    {
      "type": "event",
      "name": "deploy_web_development",
      "handler": "stretcher"
    }
  ]
}
EOF

systemctl start consul
