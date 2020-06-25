class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :home_player_id
      t.integer :away_player_id
      t.integer :home_score
      t.integer :away_score
      t.integer :championship_id

      t.timestamps
    end
  end
end
