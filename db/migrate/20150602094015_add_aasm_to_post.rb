class AddAasmToPost < ActiveRecord::Migration
  def change
    add_column :posts, :aasm_state, :string, default: 'draft'
  end
end
