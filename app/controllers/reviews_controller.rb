class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.booking = @review
    if @review.save
      redirect_to review_path(@review), notice: 'Thank you for your review!'
    else
      render :new, status: :unprocessable_entity

    def destroy
      if @review.update(status: params[:status])
          redirect_to user_path(current_user)
      else
          redirect_to item_path(@item)
      end
  end

  private

  def set_review
    @review = Review.find(params[:booking_id])
  end

  def review_params
    params[:review].permit(:comment, :rating)
  end
end
