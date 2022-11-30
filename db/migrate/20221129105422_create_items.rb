class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.string :condition
      t.text :description
      t.string :item_picture
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
