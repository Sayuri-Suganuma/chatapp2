class Chatroom < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :partner, class_name: 'User', foreign_key: 'partner_id'
  has_many :chats, dependent: :destroy
end
