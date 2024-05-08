class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :owned_chatrooms, class_name: 'Chatroom', foreign_key: 'owner_id', dependent: :destroy
  has_many :partnered_chatrooms, class_name: 'Chatroom', foreign_key: 'partner_id', dependent: :destroy
end
