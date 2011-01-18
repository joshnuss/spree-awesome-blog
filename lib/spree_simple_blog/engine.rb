require "spree_simple_blog"

module SpreeSimpleBlog

  class Engine < Rails::Engine

    def self.activate
      Spree::BaseHelper.module_eval do
        def link_to_rss 
          tag(:link,
            :rel => 'alternate',
            :type => "application/rss+xml", 
            :title => Spree::Config[:blog_title] || "#{Spree::Config[:site_name]} Blog",
            :href =>  posts_path(:format => :rss))
        end

        def markdown(text)
          sanitize(BlueCloth.new(text).to_html)
        end
      end
      
    end
    
    config.root = (Pathname.new(File.dirname(File.expand_path(__FILE__))) + "../../").to_s
    config.to_prepare &method(:activate).to_proc

  end

end
