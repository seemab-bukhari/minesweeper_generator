class CreateTiles < ActiveRecord::Migration[7.1]
  def change
    create_table :tiles do |t|
      t.integer :x
      t.integer :y
      t.boolean :mine, default: false
      t.references :board, null: false, foreign_key: true

      t.index [:x, :y, :board_id]
      t.timestamps
    end
  end
end
