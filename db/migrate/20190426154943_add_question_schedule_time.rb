class AddQuestionScheduleTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :question_time
    create_table :question_schedule_times, force: true do |t|
      t.string   'question_time',  null: false
    end
    add_reference :question_schedule_times, :team, foreign_key: true, null: true
  end
end
