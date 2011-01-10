class Admin::PostsController < Admin::BaseController
  resource_controller

  helper 'spree/base'

  new_action.response do |format|
    format.html {render :action => :new, :layout => false}
  end
  update.response do |format|
    format.html { redirect_to admin_posts_path }
  end
  create.response do |format|
    format.html { redirect_to edit_admin_posts_path(@posts) }
  end
private
  def collection
    @collection ||= Post.paginate(:page => params[:page], :per_page => 10)
  end
end
