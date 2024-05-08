class CreateChatrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chatrooms do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :partner, null: false, foreign_key: { to_table: :users }
      t.string :title

      t.timestamps
    end
  end
end
