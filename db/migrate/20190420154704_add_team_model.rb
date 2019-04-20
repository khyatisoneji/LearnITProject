class AddTeamModel < ActiveRecord::Migration[5.2]
  def change
    create_table :teams, force: true do |t|
      t.string   'team_id'
      t.string   'name'
      t.boolean  'active', default: true
      t.string   'domain'
      t.string   'token'
      t.datetime 'created_at',                                 null: false
      t.datetime 'updated_at',                                 null: false
      t.string   'bot_user_id'
      t.string   'activated_user_id'
      t.string   'activated_user_access_token'
    end
  end
end
