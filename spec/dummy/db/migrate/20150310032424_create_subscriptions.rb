class CreateSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.boolean :paused, default: false, null: false

      t.timestamps null: false
    end
  end
end
