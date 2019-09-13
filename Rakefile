require "rake/testtask"

Rake::TestTask.new do |t|
  name = File.basename(ENV["BUNDLE_GEMFILE"], ".gemfile")
  t.libs << "test"
  t.test_files = ["test/#{name}_test.rb"]
  t.warning = false
end

def run(command)
  unless system(command)
    raise "Command failed: #{command}"
  end
end

task :audit do
  Bundler.with_clean_env do
    run "bundle audit --update"
    run "bundle exec appraisal bundle audit"
  end
end
