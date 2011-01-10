class PostsController < Spree::BaseController

  def index
    @tag   = params[:tag]
    @year  = params[:year]
    @month = params[:month]
    @day   = params[:day]

    @posts = @year ? Post.by_date(@year, @month, @day) : Post
    @posts = @posts.published
    @posts.tagged_with(@tag) if @tag
    
    @posts = @posts.paginate(:page => params[:page])
  end

  def show
    @post = Post.published.find_by_permalink(params[:id])
  end

end
