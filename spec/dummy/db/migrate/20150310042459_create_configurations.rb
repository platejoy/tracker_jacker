class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.belongs_to :user
      t.string :color
      t.string :age
      t.string :height

      t.timestamps null: false
    end
  end
end
