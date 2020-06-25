class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :punctuation
      t.integer :victories
      t.integer :defeats
      t.integer :ties
      t.integer :home_victories
      t.integer :away_victories
      t.integer :bonus
      t.integer :punishment
      t.integer :championship_id

      t.timestamps
    end
  end
end
