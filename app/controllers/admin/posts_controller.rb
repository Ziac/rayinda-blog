class Admin::PostsController < Admin::BaseController

  before_filter :require_admin
  
  def index
    @posts = @post_status.page(params[:page]).per(5)
  end

  def show
    @post = @post_status.find(params[:id])
  end

  def edit
    @post = @post_status.find(params[:id])
    @available_categories = Category.all
  end

  def update
    @post = @post_status.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to [:admin, @post], notice: 'Post was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @post = @post_status.find(params[:id]).destroy
    redirect_to admin_posts_url
  end

  def set_post

  end

end
