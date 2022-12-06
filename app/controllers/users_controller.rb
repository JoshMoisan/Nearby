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
    @chatroom_name = get_name(@user, current_user)
    @chatroom = Chatroom.where(name: @chatroom_name).first
  end

  def edit
  end

  def showtool
    if params[:category].present?
      @items = @items.where(category: params[:category])
    else
      @items = Item.all
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def get_name(user1, user2)
    users = [user1, user2]
    "Chat with #{users[0].username}"
  end
end
