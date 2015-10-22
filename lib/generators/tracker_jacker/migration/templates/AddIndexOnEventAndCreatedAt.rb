class AddIndexOnEventAndCreatedAt < ActiveRecord::Migration
  def change
    add_index :trackable_events, [:event, :created_at]
  end
end
