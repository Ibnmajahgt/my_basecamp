class RemoveThreadIdFromMessages < ActiveRecord::Migration[8.0]
  def change
    remove_column :messages, :thread_id, :integer
  end
end
