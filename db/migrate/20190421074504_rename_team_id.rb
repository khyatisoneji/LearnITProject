class RenameTeamId < ActiveRecord::Migration[5.2]
  def change
    rename_column :teams, :team_id, :slack_team_id
  end
end
