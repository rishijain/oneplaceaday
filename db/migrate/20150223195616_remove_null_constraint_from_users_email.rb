class RemoveNullConstraintFromUsersEmail < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, :null => true, default: ''
  end
end
