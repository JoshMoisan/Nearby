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
  end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
