#!/bin/bash

datetime=`date +%s`
status_code=$1
datetime_code=`expr ${datetime} \* 1000 + ${status_code}`
node_name=`curl -s localhost:8500/v1/agent/self | python -c "exec(\"import json,sys\\nj=json.load(sys.stdin)\\nprint j['Member']['Name']\")"`
log=`cat $2`


curl -X PUT -d "$log" "localhost:8500/v1/kv/dashboard/chef/${node_name}?flags=${datetime_code}"
