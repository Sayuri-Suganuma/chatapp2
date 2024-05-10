class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.text :content
      t.string :sender_name
      t.references :room, null: false, foreign_key: { to_table: :chatrooms }
      t.references :chatroom, null: false, foreign_key: true
      t.datetime :sent_at

      t.timestamps
    end
  end
end
