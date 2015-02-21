module PostsHelper
  def post_is_editable?(author, logged_in_user)
    author == logged_in_user
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

  def map_image(latitude, longitude)
    image_tag "http://maps.googleapis.com/maps/api/staticmap?size=450x300&zoom=15&markers=#{latitude}%2C#{longitude}"
  end
end
