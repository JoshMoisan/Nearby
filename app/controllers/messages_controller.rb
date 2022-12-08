class MessagesController < ApplicationController

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    @message.save!
    other_user = @chatroom.participants.find{|participant| participant.user != current_user}.user

      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: {message: @message})
      )

      NotificationChannel.broadcast_to(
        other_user,
        1
      )
      head :ok
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
