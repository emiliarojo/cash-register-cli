require 'rake/testtask'
require 'rspec/core/rake_task'

# Run all RSpec tests
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

# Run the application
task :run do
  ruby 'lib/checkout.rb'
end

# Default task
task default: [:spec]
