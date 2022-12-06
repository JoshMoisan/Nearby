class AddAmountOfDaysToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :amount_of_days, :integer
  end
end
