class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.integer :home_score
      t.integer :away_score
      t.integer :match_id

      t.timestamps
    end
  end
end
