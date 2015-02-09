module PostsHelper
  def post_is_editable?(action, user_id)
    true if action == 'posts' and current_user and current_user.id == user_id
  end

  def value_of_user_id(user)
    user.nil? ? nil : user.id
  end

  def image_for_current_user(user)
    return user.profile_photo.url if user.present? and user.profile_photo.url.present?
    'nouserimage.png'
  end

  def username_for_user(user)
    return 'Anonymous User' if user.nil?
    user.username
  end
end
