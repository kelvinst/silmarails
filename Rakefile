begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Silmarails'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end



Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test

namespace :templates do
  # desc "Copy all the templates from rspec to the application directory for customization. Already existing local copies will be overwritten"
  task :rspec do
    generators_lib = File.join(Gem.loaded_specs["rspec-rails"].full_gem_path, "lib/generators")
    project_templates = "./lib/templates"

    default_templates = { "rspec" => %w{controller helper integration mailer model observer scaffold view} }

    default_templates.each do |type, names|
      local_template_type_dir = File.join(project_templates, type)
      FileUtils.mkdir_p local_template_type_dir

      names.each do |name|
        dst_name = File.join(local_template_type_dir, name)
        src_name = File.join(generators_lib, type, name, "templates")
        FileUtils.cp_r src_name, dst_name
      end
    end
  end
end
