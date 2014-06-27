require "bundler/gem_tasks"
require 'rubocop/rake_task'
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new { |t|
  t.libs << "test"
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = true
}

RuboCop::RakeTask.new
