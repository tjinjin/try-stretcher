directory '/etc/consul.d'

template '/etc/consul.d/server.json' do
  variables(
    bind_addr: node['automatic']['ipaddress'],
    node_name: node['automatic']['ipaddress']
  )
  notifies :start, 'service[consul]'
  notifies :reload, 'service[consul]'
end

