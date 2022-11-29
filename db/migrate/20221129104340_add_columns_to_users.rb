class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :description, :text
    add_column :users, :profile_picture, :string
    add_column :users, :address, :string
    add_column :users, :identification_picture, :string
    add_column :users, :verified, :boolean
    add_column :users, :tokens, :integer
  end
end
