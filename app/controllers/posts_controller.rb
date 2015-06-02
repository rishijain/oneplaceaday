class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show, :add_comment]

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(permit_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update(permit_params)
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def index
    @posts = Post.published.order('views_count DESC , created_at DESC')
    Statistic.increment_counter(:count, Statistic.home_page_view_count.id)
  end

  def show
    @post = Post.find params[:id]
    Post.increment_counter(:views_count, @post.id) if @post.user_id != current_user.try(:id)
    @suggested_posts = Post.all_except(@post.id).sample(2)
  end

  def add_comment
    post = Post.find(params[:id])
    post.comments.create(user_id: params[:comment][:user_id], thought: params[:comment][:thought])
    redirect_to post_path(post.id)
  end

  def draft_posts
    @posts = current_user.published_posts
    render 'index'
  end

  private

  def permit_params
    params.require(:post).permit(:id, :title, :description, :country, :place, :visited_on, :photo, :user_id)
  end
end
