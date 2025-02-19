class AddDiscussionIdToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :discussion_id, :integer, null: false, default: 0
    add_index :messages, :discussion_id
  end
end
