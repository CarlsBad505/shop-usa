class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.text :description
      t.integer :shipping_charge
      t.string :track_package
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
