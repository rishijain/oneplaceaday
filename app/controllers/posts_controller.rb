class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show, :add_comment]
  before_filter :build_post, only: [:new, :create]
  before_filter :get_post, only: [:show, :update]

  def create
    respond_to do |format|
      format.json do
        if @post.save
          render(nothing: true, status: :ok)
        else
          render(json: { data: { errors: @post.errors.messages }}, status: :unprocessable_entity)
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        if @post.update(permit_params)
          render(nothing: true, status: :ok)
        else
          render(json: { data: { errors: @post.errors.messages }}, status: :unprocessable_entity)
        end
      end
    end
  end

  def index
    @posts = Post.all.order('views_count DESC , created_at DESC')
    Statistic.increment_counter(:count, Statistic.home_page_view_count.id)
  end

  def show
    Post.increment_counter(:views_count, @post.id) if @post.user_id != current_user.try(:id)
    @suggested_posts = Post.all_except(@post.id).sample(2)
  end

  def add_comment
    post = Post.find(params[:id])
    post.comments.create(user_id: params[:comment][:user_id], thought: params[:comment][:thought])
    redirect_to post_path(post.id)
  end

  private

  def permit_params
    params.fetch(:post).permit(:title, :description, :country, :place, :visited_on, :photo)
  end

  def build_post
    @post = current_user.posts.new(permit_params)
  end

  def get_post
    @post = Post.find(params[:id])
  end
end
