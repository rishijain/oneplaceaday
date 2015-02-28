class LikesController < ApplicationController

  before_filter :authenticate_user!

  def up_or_down
    like = current_user.likes.where(post_id: params[:post_id]).first
    if like.nil?
      @action = 'like'
      like = current_user.likes.create(post_id: params[:post_id])
      @update_by = +1
    else
      @action  = 'unlike'
      like.destroy
      @update_by = -1
    end
    post = Post.find params['post_id']
    post.update_column(:likes_count, post.likes_count + @update_by)
    @likes_count = post.likes_count
  end
end
