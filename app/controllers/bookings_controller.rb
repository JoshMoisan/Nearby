class BookingsController < ApplicationController
  before_action :set_item
  before_action :set_booking, only: %i[show update destroy]


  def index
    @bookings = current_user.bookings
  end

  def show
  end

  def new
    @booking = Booking.new
    @marker = [{
      lat: @item.user.latitude,
      lng: @item.user.longitude,
      info_window: render_to_string(partial: "items/info_window", locals: { item: @item })
    }]
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.item = @item
    if @booking.save
      redirect_to booking_path(@booking) , notice: "Successfully created a booking."
    else
      redirect_to item_path(@item)
    end
  end


  def update
    @booking.user = current_user
    if @booking.update(status: params[:status])
      redirect_to user_path(current_user)
    else
      redirect_to item_path(@item)
    end
  end

  def destroy
    @booking.user = current_user
    if @booking.destroy
      redirect_to user_path(current_user)
    else
      redirect_to item_path(@item)
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def booking_params
    params[:booking].permit(:start_date, :end_date, :price_in_token, :amount_of_days)
  end
end
