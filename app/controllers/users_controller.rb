class UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.all
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window: render_to_string(partial: "info_window", locals: { user: })
      }
    end
  end

  def show
    @current_user = User.find(params[:id])

    # @review = current_user
    @items = current_user.items
    # @bookings = Booking.all
    # @reviews = Booking.last.reviews

    # CHAT
    @chatroom = Chatroom.new
    @message = Message.new
    @chatroom_name = get_name(@user, @current_user)
    @single_chatroom = Chatroom.where(name: @chatroom_name).first || Chatroom.create_private_room([@user, @current_user], @room_name)
    @messages = @single_chatroom.messages

  end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end

end
