directory '/etc/consul.d'

template '/etc/consul.d/server.json' do
  variables(
    bind_addr: node['consul']['ipaddress'],
    node_name: node['consul']['ipaddress'],
    leader_addr: node['consul']['leader_addr'],
    environment: node['environment']
  )
  notifies :start, 'service[consul]'
  notifies :reload, 'service[consul]'
end

