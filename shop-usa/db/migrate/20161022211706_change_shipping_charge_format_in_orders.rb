class ChangeShippingChargeFormatInOrders < ActiveRecord::Migration[5.0]
  def up
    change_column :orders, :shipping_charge, :float
  end
  
  def down
    change_column :orders, :shipping_charge, :integer
  end
end
