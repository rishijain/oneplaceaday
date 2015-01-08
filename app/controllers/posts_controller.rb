class PostsController < ApplicationController

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

  def index
    @posts = Post.all.order('created_at DESC')
  end

  private

  def permit_params
    params.require(:post).permit(:id, :title, :description, :country, :place, :visited_on)
  end
end
