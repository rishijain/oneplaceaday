class GeneralUserHelper

  def initialize(user)
    @user = user
  end

  def draft_posts
    @user.draft_posts
  end

  def moderated_posts
    @user.moderation_posts
  end

  def published_posts
    @user.published_posts
  end
end
