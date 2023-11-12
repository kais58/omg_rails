class AddEloToPlayers < ActiveRecord::Migration[6.1]
  def change
    change_table :players do |t|
      t.integer  :elo, default: 1500, null: false
      t.decimal  :sigma, default: 0, null: false
    end
  end
end
