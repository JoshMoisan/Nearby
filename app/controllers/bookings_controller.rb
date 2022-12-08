class BookingsController < ApplicationController
  before_action :set_item, except: :index
  before_action :set_booking, only: %i[show update destroy]

  def index
    @bookings = current_user.bookings
    @item = Item.all
  end

  def show
  end

  def new
    @booking = Booking.new
    @item = Item.find(params[:item_id])
    # @chatroom = Chatroom.find(params[:id])

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
    @booking.price_in_token = @item.price * params[:booking][:amount_of_days].to_i
    if @booking.save
      end_date = @booking.start_date + @booking.amount_of_days
      @booking.update(end_date: end_date)
      current_user.update(tokens: current_user.tokens - @booking.price_in_token)
      @booking.item.user.update(tokens: current_user.tokens + @booking.price_in_token)
      redirect_to booking_path(@booking), notice: "Successfully booked!"
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
