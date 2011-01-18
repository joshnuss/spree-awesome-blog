module SpreeSimpleBlog
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Configures your Rails application for use with spree_simple_blog"
      def copy_files
        directory "db"
        directory "public"
      end

    end
  end
end
