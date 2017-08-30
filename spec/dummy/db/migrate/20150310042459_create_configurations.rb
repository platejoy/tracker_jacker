class CreateConfigurations < ActiveRecord::Migration[4.2]
  def change
    create_table :configurations do |t|
      t.belongs_to :user
      t.string :color
      t.integer :age
      t.decimal :height, scale: 2, precision: 5

      t.timestamps null: false
    end
  end
end
