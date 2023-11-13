class AddEloToPlayers < ActiveRecord::Migration[6.1]
  def change
    change_table :players do |t|
      t.integer  :elo, default: 1500, null: false
      t.integer  :rd, default: 350, null: false
      t.float    :vol, default: 0.06, null: false
    end
  end
end
