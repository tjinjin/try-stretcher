ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

role :build, ['192.168.34.42'], :no_release => true
set :application, 'try-stretcher'
set :deploy_to, '/var/www/try-stretcher'
set :deploy_roles, 'web'
set :stretcher_hooks, 'config/stretcher.yml.erb'
set :local_tarball_name, 'chef.tar.gz'
set :stretcher_src, "s3://tjinjin-server-stretcher/assets/chef-#{env.now}.tgz"
set :manifest_path, "s3://tjinjin-server-stretcher/manifests"
set :repo_url, 'https://github.com/tjinjin/try-stretcher'
