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
    page_number = params["page"] || 1
    @posts = Post.page(page_number).order('created_at DESC')
  end

  def show
    @post = Post.find params[:id]
  end

  def add_comment
    post = Post.find(params[:id])
    post.comments.create(user_id: params[:comment][:user_id], thought: params[:comment][:thought])
    redirect_to post_path(post.id)
  end

  private

  def permit_params
    params.require(:post).permit(:id, :title, :description, :country, :place, :visited_on, :photo, :user_id)
  end
end
