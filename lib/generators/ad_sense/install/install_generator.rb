require 'rails/generators'
module AdSense
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "This generator creates an initializer file for AdSense at config/initializers"

      def add_initializer
        template "initializer.rb", "config/initializers/ad_sense.rb"
      end

      def show_readme
        readme "README"
      end
    end
  end
end
