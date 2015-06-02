namespace 'db' do
  desc "set state of old posts to published"
  task publish_posts: :environment do
    Post.all.each do |post|
      post.aasm_state = 'published'
      post.save!
    end
  end
end

