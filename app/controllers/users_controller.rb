class UsersController < ApplicationController
  before_action :set_user, except: [:showtool]

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
    @items = @user.items
    @user_reviews = Review.joins(booking: :item).where("items.user_id=?", @user)
  end

  def edit
  end

  def showtool
    @user = User.find(params[:user_id])
    @items = @user.items
    if params[:category].present?
      @items = @user.items.where(category: params[:category])
    else
      @items = @user.items.all
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
