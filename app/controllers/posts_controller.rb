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
    @posts = Post.published
    if params[:query].present?
      @posts = @posts.search(params[:query])
    end
    @posts = @posts.order('views_count DESC, created_at DESC')
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
    @posts = current_user.draft_posts
    render 'index'
  end

  def published_posts
    @posts = current_user.published_posts
    render 'index'
  end

  def moderated_posts
    @posts = current_user.moderation_posts
    render 'index'
  end

  def change_state
    @post = Post.find params[:id]
    if next_state_and_current_state_same?(params)
      @message = "Post is already in #{@post.aasm_state} state."
      @message_type = "info"
    else
      update_state(params)
      @message = "Post is moved to #{@post.aasm_state} state."
      @message_type = "success"
    end
  end

  private

  def permit_params
    params.require(:post).permit(:id, :title, :description, :country, :place, :visited_on, :photo, :user_id, :aasm_state)
  end

  def next_state_and_current_state_same?(params)
    params[:next_state] == @post.aasm_state
  end

  def update_state(params)
    if params[:next_state] == 'draft'
      @post.draft!
    elsif params[:next_state] == 'moderation'
      @post.moderate!
    elsif params[:next_state] == 'published'
      @post.publish!
    end
  end
end
