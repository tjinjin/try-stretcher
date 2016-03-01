require 'serverspec'

set :backend, :exec

Dir[File.expand_path('{shared,support}/*.rb', File.dirname(__FILE__))].each do |file|
  require file
end
