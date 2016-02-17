pkg_version = '0.6.3'
archive_file = "consul_#{pkg_version}_web_ui.zip"
index_file= 'consul'
deploy_path = '/var/consul/web_ui'

%w(/var/consul /var/consul/web_ui).each do |dir|
  directory dir
end

remote_file "#{deploy_path}/#{archive_file}" do
  source "https://releases.hashicorp.com/consul/#{pkg_version}/#{archive_file}"
  not_if { File.exist?("#{deploy_path}/#{archive_file}") }
end

execute 'deploy files' do
  command <<-EOC
    cd #{deploy_path}
    unzip #{archive_file}
  EOC
end
