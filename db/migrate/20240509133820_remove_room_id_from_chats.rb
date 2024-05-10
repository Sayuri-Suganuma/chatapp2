class RemoveRoomIdFromChats < ActiveRecord::Migration[7.1]
  def change
    remove_column :chats, :room_id, :integer
  end
end
