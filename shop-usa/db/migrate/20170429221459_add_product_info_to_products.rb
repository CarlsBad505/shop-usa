class AddProductInfoToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :photo, :string
    add_column :products, :description, :text
  end
end
