class RemoveUpdatedAt < ActiveRecord::Migration
  def change
    remove_column :trackable_events, :updated_at
  end
end
