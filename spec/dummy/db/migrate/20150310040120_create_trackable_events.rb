# Migration responsible for creating trackable events
class CreateTrackableEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :trackable_events do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.belongs_to :owner, :polymorphic => true

      t.string :category
      t.string :event
      t.text :new_value
      t.text :old_value

      t.timestamps null: false
    end

    add_index :trackable_events, [:trackable_id, :trackable_type]
    add_index :trackable_events, [:owner_id, :owner_type]
  end
end
