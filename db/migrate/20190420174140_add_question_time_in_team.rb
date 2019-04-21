class AddQuestionTimeInTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :question_time, :string, null: false, default: '10:00'
  end
end
