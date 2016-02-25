require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format json --out #{ENV['CIRCLE_TEST_REPORTS']}/cucumber/tests.cucumber"
end

task :build do
  sh "docker build -t shift/mosquitto-auth-plug-build ."
end

task :audit do
  sh "docker run -it shift/mosquitto-auth-plug-build apk audit"
  sh "docker run -it shift/mosquitto-auth-plug-build apk stats"
end

task :default => [:build, :features, :audit, :create_private_key, :package]

task :create_private_key do
  sh "docker run -it -v $(pwd)/keys:/home/automation/.abuild shift/mosquitto-auth-plug-build abuild-keygen -a -n"
end

task :package do
  sh "docker run -it -v $(pwd)/pkg:/home/automation/packages -v $(pwd)/apkbuild:/home/automation/mosquitto-auth-plug -v $(pwd)/keys:/home/automation/.abuild shift/mosquitto-auth-plug-build abuild -r"
  sh "mkdir -p $CIRCLE_ARTIFACTS && mv $(find pkg/automation/x86_64 -name \"*.apk\") $CIRCLE_ARTIFACTS/"
end

