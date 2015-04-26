class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.string :page_type
      t.integer :count, default: 0
      t.timestamps null: false
    end
  end
end
