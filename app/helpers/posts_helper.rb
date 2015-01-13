module PostsHelper
  def post_is_editable?(action, user_id)
    true if action == 'posts' and current_user.id == user_id
  end
end
