class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :place
      t.string :country
      t.string :visited_on

      t.timestamps
    end
  end
end
