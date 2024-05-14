class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /chatrooms or /chatrooms.json
  def index
    # @chatrooms = Chatroom.all
    if current_user
      @chatrooms = Chatroom.where(owner_id: current_user.id).or(Chatroom.where(partner_id: current_user.id))
    else
      redirect_to new_user_session_path, notice: "Please log in!!" 
    end
  end

  # GET /chatrooms/1 or /chatrooms/1.json
  def show
    @chat = Chat.new
    @chatroom = Chatroom.find(params[:id])
    @chats = @chatroom.chats

    # @chats = chat.where(chatroom: id)
  end

  def add_comment
    @chat = Chat.new(chat_params)
    @chatroom = Chatroom.find(params[:chatroom_id])
    @chat = @chatroom.chats.build(chat_params)
    @chat.sender_id = current_user.id
    Rails.logger.debug(@chat.errors.full_messages)
    if @chat.save
      redirect_to @chatroom
    else
      flash[:alert] = "Comment not found."    
    end
  end

  # GET /chatrooms/new
  def new
    @chatroom = Chatroom.new
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms or /chatrooms.json
  def create
    @chatroom = Chatroom.new(
      owner_id: chatroom_params[:owner_id],
      partner_id: chatroom_params[:partner_id],
      title: chatroom_params[:title]
    )

    respond_to do |format|
      if @chatroom.save
        format.html { redirect_to chatroom_url(@chatroom), notice: "Chatroom was successfully created." }
        format.json { render :show, status: :created, location: @chatroom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  # PATCH/PUT /chatrooms/1 or /chatrooms/1.json
  def update
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        format.html { redirect_to chatroom_url(@chatroom), notice: "Chatroom was successfully updated." }
        format.json { render :show, status: :ok, location: @chatroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1 or /chatrooms/1.json
  def destroy
    @chatroom.destroy!

    respond_to do |format|
      format.html { redirect_to chatrooms_url, notice: "Chatroom was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    def chat_params
      params.require(:chat).permit(:content, :sender_id, :chatroom_id)
    end


    # Only allow a list of trusted parameters through.
    def chatroom_params
      params.require(:chatroom).permit(:title, :owner_id, :partner_id)
    end
end
