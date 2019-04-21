class AddUserDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string
    add_column :users, :user_name, :string
    add_column :users, :team_id, :int
    add_column :users, :user_id, :string
    add_reference :users, :teams, foreign_key: true, null: true
    remove_column :users, :email
    remove_column :users, :name
  end
end
