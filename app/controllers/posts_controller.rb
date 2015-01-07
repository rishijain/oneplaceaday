class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    Post.create(permit_params)
  end

  private

  def permit_params
    params.require(:post).permit(:id, :title, :description, :country, :place, :visited_on)
  end
end
