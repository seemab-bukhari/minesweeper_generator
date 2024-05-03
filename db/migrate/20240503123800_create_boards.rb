class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :total_mines, null: false

      t.timestamps
    end
  end
end
