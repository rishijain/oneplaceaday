class HomeController < ApplicationController

  def about
    Statistic.increment_counter(:count, Statistic.about_page_view_count.id)
  end
end
