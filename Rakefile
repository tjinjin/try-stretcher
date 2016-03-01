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

class ServerspecTask < RSpec::Core::RakeTask
  attr_accessor :target

  def spec_command
    cmd = super
    "#{cmd}"
  end
end

namespace :spec do
  desc "Run serverspec to all hosts"
  task :all => roles.map {|h| 'spec:' + h[:short_name] }
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
