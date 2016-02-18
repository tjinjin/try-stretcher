pkg_version = '0.0.7'
work_path = '/tmp'
archive_file = "consul-kv-dashboard-v#{pkg_version}-linux-amd64.zip"
unpackage_file = "#{File.basename(archive_file, '.zip')}"
binary_file = 'consul-kv-dashboard'
deploy_path = '/usr/local/bin'


remote_file "#{work_path}/#{archive_file}" do
  source "https://github.com/fujiwara/consul-kv-dashboard/releases/download/v#{pkg_version}/#{archive_file}"
  not_if { File.exist?("#{deploy_path}/#{binary_file}") }
  notifies :run, 'execute[deploy binary consul-kv-dashboard]'
end

execute 'deploy binary consul-kv-dashboard' do
  command <<-EOC
    cd #{work_path}
    unzip #{archive_file}
    mv #{unpackage_file} #{deploy_path}/#{binary_file}
  EOC
  action :nothing
end

cookbook_file '/etc/systemd/system/consul-kv-dashboard.service' do
  notifies :run, 'execute[systemd-daemon-reload]', :immediately
end

service 'consul-kv-dashboard' do
  action [:enable, :start]
  supports start: true
end
