class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @items = Item.search_by(params[:query])
    else
      @items = Item.all
    end
    users = @items.map(&:user)
    @markers = users.uniq.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window: render_to_string(partial: "users/info_window", locals: {user: user})
      }
    end
    @markers.compact
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @user = current_user
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to new_item_booking_path(@item), notice: 'This item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @item.user = current_user
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path(@item)
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params[:item].permit(:name, :category, :condition, :description, :photo, :price)
  end
end
