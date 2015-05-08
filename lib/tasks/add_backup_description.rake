namespace 'db' do
  desc "copy values of description to back up description"
  task copy_back_descr: :environment do

    Post.all.each do |p|
      p.update_column(:backup_description, p.description)
    end

  end
end
