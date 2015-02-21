class SearchService
  def by_username(name)
    @users = User.search(name)
  end
end
