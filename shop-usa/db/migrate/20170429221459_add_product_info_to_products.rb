class AddProductInfoToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :photo, :string
    add_column :products, :description, :text
    add_column :products, :shipping, :decimal, precision: 12, scale: 2
    add_column :products, :tax, :decimal, precision: 12, scale: 2
  end
end
