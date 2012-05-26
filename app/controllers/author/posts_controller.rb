class Author::PostsController < ApplicationController

  before_filter :require_author, :except => [:show, :index]

  def autocomplete_tag_name
    render json: Tag.where("name like '#{params[:q]}%'")
  end
  
  def index
    @posts = Post.where(:user_id => current_user.id).page(params[:page]).per(5)
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def new
    @post = current_user.posts.new
    @available_categories = Category.all
  end

  def edit
    @post = current_user.posts.find(params[:id])
    @available_categories = Category.all
  end

  def create
    @post = current_user.posts.new(params[:post])
    @post.published_at = Time.now if @post.published
    if @post.save
      redirect_to author_mypost_path(@post), notice: 'Post was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.published_at = Time.now if (params[:post][:published] && @post.published_at.nil?)
    if @post.update_attributes(params[:post])
      redirect_to author_mypost_path(@post), notice: 'Post was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    current_user.posts.find(params[:id]).destroy
    redirect_to author_myposts_path, notice: 'The post was deleted successfully'
  end
end
