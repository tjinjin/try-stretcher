require 'rake'
require 'rake/stretcher/chef'
require 'rspec/core/rake_task'

task :spec    => 'spec:all'
task :default => :spec

roles = [
  {
    name: 'development-web-server',
    short_name: 'dev:web',
    role: 'dev_web'
  },
  {
    name: 'development-batch-server',
    short_name: 'dev:batch',
    role: 'dev_batch'
  }
]

hosts = [
  {
    name: '192.168.34.42',
    short_name: 'vm:app01',
    role: 'vm_web'
  },
  {
    name: '192.168.34.43',
    short_name: 'vm:app02',
    role: 'vm_web'
  }
]

class ServerspecTask < RSpec::Core::RakeTask
  attr_accessor :target

  def spec_command
    cmd = super
    "env TARGET_HOST=#{target} #{cmd}"
  end
end

namespace :spec do
  desc "Run serverspec to all hosts"
  hosts.each do |host|
    desc "Run serverspec to #{host[:name]}"
    ServerspecTask.new(host[:short_name].to_sym) do |t|
      t.target = host[:name]
      t.pattern = "spec/roles/#{host[:role]}_spec.rb"
    end
  end

  desc "Run serverspec to roles"
  roles.each do |role|
    desc "Run serverspec to #{role[:name]}"
    ServerspecTask.new(role[:short_name].to_sym) do |t|
      t.target = 'localhost'
      t.pattern = "spec/roles/#{role[:role]}_spec.rb"
    end
  end
end

Dir['tasks/*.rake'].each do |f|
  load File.join(File.dirname(__FILE__), f)
end
