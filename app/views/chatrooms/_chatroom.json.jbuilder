json.extract! chatroom, :id, :owner_id, :partner_id, :title, :created_at, :updated_at
json.url chatroom_url(chatroom, format: :json)
