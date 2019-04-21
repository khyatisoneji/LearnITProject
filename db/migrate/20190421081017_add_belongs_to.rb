class AddBelongsTo < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :team_id
    remove_column :questions, :team_id
    add_reference :users, :team, foreign_key: true
    add_reference :questions, :team, foreign_key: true
  end
end
