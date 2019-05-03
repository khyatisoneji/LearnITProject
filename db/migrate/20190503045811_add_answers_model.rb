class AddAnswersModel < ActiveRecord::Migration[5.2]
  def change
    create_table :answers, force: true do |t|
      t.string   'answer'
      t.timestamps
    end
    add_reference :answers, :question, foreign_key: true
  end
end
