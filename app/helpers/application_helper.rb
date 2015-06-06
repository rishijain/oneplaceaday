module ApplicationHelper
  def navigation_active_class(params_page, page_number)
    return 'active' if params_page == page_number.to_s or (params_page.nil? and page_number == 1)
  end

  def posts_index_page? params
    params[:controller] == 'posts' and params[:action] == 'index'
  end

  def user_profile_page? params
    params[:controller] == 'users' and params[:action] == 'show'
  end

  def social_media_image(provider)
    if provider == 'facebook'
      name = 'facebook.png'
    elsif provider == 'twitter'
      name = 'twitter.png'
    end
    name
  end
end
