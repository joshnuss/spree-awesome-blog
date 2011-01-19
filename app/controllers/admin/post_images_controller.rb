class Admin::PostImagesController < Admin::BaseController
  resource_controller
  belongs_to :post

  new_action.response do |wants|
    wants.html {render :action => :new, :layout => false}
  end

  create.response do |wants|
    wants.html {redirect_to admin_post_images_url(@post)}
  end

  update.response do |wants|
    wants.html {redirect_to admin_post_images_url(@post)}
  end

  create.before :set_viewable
  update.before :set_viewable
  destroy.before :destroy_before

  destroy.response do |wants|
    wants.html do
      render :text => ""
    end
  end


private
  def parent_object
    @parent_object ||= Post.find_by_permalink(params[:post_id])
  end

  def object
    @object ||= end_of_association_chain.find(params[:id])
    @image = @object
  end

  def model_name
    'image'
  end

  def object_name
    'image'
  end

  def set_viewable
    object.viewable = @post
  end

  def destroy_before
    @viewable = object.viewable
  end


end
