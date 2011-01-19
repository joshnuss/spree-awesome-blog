class SpreeFaqHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_tabs do
    %(<%= tab(:posts, :label => :blog) %>)
  end

  insert_after :admin_inside_head do
    %(<%= javascript_include_tag 'jquery.markitup.showdown.js', 'admin/blog.js' %> <%= stylesheet_link_tag 'admin/blog' %>)
  end
end

