class AdminUserHelper

  def initialize(user)
    @user = user
  end

  def draft_posts
    Post.draft
  end

  def moderated_posts
    Post.moderation
  end

  def published_posts
    Post.all
  end
end
