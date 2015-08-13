require 'rake/extensiontask'
require 'rspec/core/rake_task'

Rake::ExtensionTask.new('re2')

RSpec::Core::RakeTask.new(:spec)

desc "checkout re2 source"
task :checkout do
  sh "git submodule update --init"
end
Rake::Task[:compile].prerequisites.insert(0, :checkout)

namespace :clean do
  task :re2 do
    FileUtils.rm_rf("vendor/re2/obj")
  end
end
Rake::Task[:clean].prerequisites << "clean:re2"


task :spec    => :compile
task :default => :spec

