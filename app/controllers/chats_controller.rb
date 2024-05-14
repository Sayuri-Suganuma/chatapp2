class ChatsController < ApplicationController
  before_action :set_chatroom, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] 

  def new
    @chat = Chat.new
    @chats = Chat.all
    @chatroom = Chatroom.find(params[:chatroom_id])
    @chats = @chatroom.chats
    # Rails.logger.debug("Current user: #{current_user.inspect}")
    # Rails.logger.debug(@chat.errors.full_messages)

  end

  def create

    # Rails.logger.debug ("#{params.to_json}")
    @chat = Chat.new(chat_params)
    @chat.sender_id = current_user.id
    @chat.user_id = current_user.id
    @chat.sent_at = Time.zone.now
    @chat.chatroom_id = params[:chat][:chatroom_id]

    Rails.logger.debug("Params: #{params.inspect}")
    Rails.logger.debug("Chat: #{@chat.inspect}")

    if @chat.save
      redirect_to new_chat_path(@chat.chatroom)
    else
      redirect_to action: :new
    end
  end

  def show
  end

  def edit
    
  end

  def update

  end

  def destroy

  end

  private
  def chat_params
    params.require(:chat).permit(:content, :sender_id, :chatroom_id)
  end

end
