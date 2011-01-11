class CommentsController < Spree::BaseController
  before_filter :load_post, :only => [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = I18n.t(:created_successfully)
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

private
  def load_post
    @post = Post.find_by_permalink(params[:post_id])
  end
end
