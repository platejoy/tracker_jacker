class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.boolean :paused, default: false, null: false

      t.timestamps null: false
    end
  end
end
