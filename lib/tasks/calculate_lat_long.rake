require 'geocoder'

namespace 'db' do
  desc "Find lat long for existing post"
  task find_lat_long: :environment do
    Post.all.each do |entry|
      address = entry.send(:full_street_address)
      s = Geocoder.search address
      if s.any?
        entry.update_column(:latitude, s[0].latitude)
        entry.update_column(:longitude, s[0].longitude)
      end
    end
  end
end
