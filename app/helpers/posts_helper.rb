module PostsHelper
  def post_is_editable?(action)
    true if action == 'posts'
  end
end
