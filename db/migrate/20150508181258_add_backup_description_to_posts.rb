class AddBackupDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :backup_description, :text
  end
end
