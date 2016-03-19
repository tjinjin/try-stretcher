require 'serverspec'
require 'net/ssh'

case ENV['TARGET_HOST']
when 'localhost'
  set :backend, :exec
else
  set :backend, :ssh

  if ENV['ASK_SUDO_PASSWORD']
    begin
      require 'highline/import'
    rescue LoadError
      fail "highline is not available. Try installing it."
    end
    set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
  else
    set :sudo_password, ENV['SUDO_PASSWORD']
  end

  host = ENV['TARGET_HOST']

  options = Net::SSH::Config.for(host)

  options[:user] ||= Etc.getlogin

  set :host,        options[:host_name] || host
  set :ssh_options, options
  #for CI using EC2
  set :request_pty, true

  # Disable sudo
  # set :disable_sudo, true


  # Set environment variables
  # set :env, :LANG => 'C', :LC_MESSAGES => 'C'

  # Set PATH
  # set :path, '/sbin:/usr/local/sbin:$PATH'
  #
end

Dir[File.expand_path('{shared,support}/*.rb', File.dirname(__FILE__))].each do |file|
  require file
end
