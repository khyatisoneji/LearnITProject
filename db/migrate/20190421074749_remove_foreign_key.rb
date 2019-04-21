class RemoveForeignKey < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :user_id, :slack_user_id
    remove_column :users, :teams_id
    add_column :questions, :team_id, :integer
  end
end
