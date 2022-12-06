class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.chatrooms
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    @user = User.find(params[:user_id])

    @chatroom = Chatroom.new
    @chatroom_name = get_name(@user, current_user)
    @chatroom = Chatroom.where(name: @chatroom_name).first || Chatroom.create_private_room([@user, current_user], @chatroom_name)
    @messages = @chatroom.messages
    redirect_to chatroom_path(@chatroom)
  end


  private

  def get_name(user1, user2)
    users = [user1, user2]
    "Chat with #{users[0].username}"
  end
end
