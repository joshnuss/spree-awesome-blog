class SpreeFaqHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_tabs do
    %(<%=  tab(:posts, :label => :blog)  %>)
  end
end

