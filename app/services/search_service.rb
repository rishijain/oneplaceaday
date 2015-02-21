class SearchService
  def by_usernames(name)
    @users = User.search(name)
  end
end
