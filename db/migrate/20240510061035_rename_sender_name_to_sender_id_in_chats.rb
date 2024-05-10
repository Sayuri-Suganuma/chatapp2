class RenameSenderNameToSenderIdInChats < ActiveRecord::Migration[7.1]
  def change
    rename_column :chats, :sender_name, :sender_id
  end
end
