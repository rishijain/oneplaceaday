module PostsHelper
  def post_is_editable?(action)
    true if action == 'my_posts'
  end
end
