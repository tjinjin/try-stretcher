template '/etc/systemd/system/consul-watch.service' do
  variables(
    role: "example_deploy"
  )
  notifies :run, 'execute[systemd-daemon-reload]',:immediately
end

execute 'systemd-daemon-reload' do
  command <<-EOC
    systemctl daemon-reload
  EOC
  action :nothing
end

service 'consul-watch' do
  action [:enable, :start]
  supports start: true, reload: true
end
