require 'rails/generators'
module Silmarails
  class InstallGenerator < Rails::Generators::Base
    class_option :framework, desc: 'Frontend framework to use (bootstrap, foundation).'

    def self.source_root
      @source_root ||= Silmarails::Engine.root.join "lib/generators/silmarails/install/files"
    end

    def install_files
      templates = self.class.source_root.join "templates"
      Dir[templates.join "**/*.*"].each do |file|
        copy_file file, "lib/templates/#{file.gsub(templates.to_s, "")}"
      end

      framework = options[:framework] || "bootstrap"
      framework_templates = self.class.source_root.join "#{framework}/templates"
      Dir[framework_templates.join "**/*.*"].each do |file|
        copy_file file, "lib/templates/#{file.gsub(framework_templates.to_s, "")}"
      end

      spec_support = self.class.source_root.join "spec/support"
      Dir[spec_support.join "**/*.*"].each do |file|
        copy_file file, "spec/support/#{file.gsub(spec_support.to_s, "")}"
      end
    end
  end
end


