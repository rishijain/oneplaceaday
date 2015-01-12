class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:my_posts]

  def posts
    user = User.find params[:id]
    @posts = user.my_posts
    render 'posts/index'
  end

end
