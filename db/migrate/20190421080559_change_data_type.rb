class ChangeDataType < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :team_id, :bigint
    change_column :questions, :team_id, :bigint
  end
end
