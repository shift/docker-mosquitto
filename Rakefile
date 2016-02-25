require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format json --out #{ENV['CIRCLE_TEST_REPORTS']}/cucumber/tests.cucumber"
end

task :build do
  sh "docker build -t shift/mosquitto ."
end

task :audit do
  sh "docker run -it shift/mosquitto apk audit"
  sh "docker run -it shift/mosquitto apk stats"
end

task :default => [:build, :audit]
