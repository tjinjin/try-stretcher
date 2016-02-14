directory '/etc/consul.d'

template '/etc/consul.d/server.json' do
  variables(
    bind_addr: node['consul']['ipaddress'],
    node_name: node['consul']['ipaddress'],
    environment: node['environment'],
    consul_deploy_role: node['consul']['deploy']['role'],
    consul_mode: node['consul']['mode']
  )
  notifies :start, 'service[consul]'
  notifies :reload, 'service[consul]'
end

