class Statistic < ActiveRecord::Base

  def self.home_page_view_count
    where(:page_type => 'home page').first
  end

  def self.about_page_view_count
    where(:page_type => 'about page').first
  end
end
