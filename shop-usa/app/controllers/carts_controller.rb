class CartsController < ApplicationController

  def show
    @order_items = current_order.order_items
    @order = current_order
    @shipping_charge = 0
    @order_items.each do |oi|
      @shipping_charge += oi.product.shipping
    end
  end

end
