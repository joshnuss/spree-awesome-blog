class PostsController < Spree::BaseController

  def index
    @tag   = params[:tag]
    @year  = params[:year]
    @month = params[:month]
    @day   = params[:day]

    @posts = @year ? Post.by_date(@year.to_i, @month.try(:to_i), @day.try(:to_i)) : Post
    @posts = @posts.published
    @posts.tagged_with(@tag) if @tag
    
    respond_to do |format|
      format.html { @posts = @posts.paginate(:page => params[:page]) }
      format.rss
    end
  end

  def show
    @post = Post.published.find_by_permalink(params[:id])
  end

end
