class Admin::CommentsController < Admin::BaseController
  resource_controller

  helper 'spree/base'

  update.response do |format|
    format.html { redirect_to admin_comments_path }
  end
  create.response do |format|
    format.html { redirect_to edit_admin_comments_path(@comments) }
  end
private
  def collection
    return @collection if @collection

    @collection = Comment
    if params[:post_id]
      @post = Post.find_by_permalink(params[:post_id])
      @collection = @post.comments
    end

    @collection = @collection.paginate(:page => params[:page], :per_page => 10)
  end
end
