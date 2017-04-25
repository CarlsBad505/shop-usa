class OrderItemsController < ApplicationController

  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    order_grand_total = 0
    @order.order_items.each do |oi|
      order_grand_total += oi.total_price
    end
    @order.update_attribute(:total, order_grand_total)
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    order_grand_total = 0
    @order.order_items.each do |oi|
      order_grand_total += oi.total_price
    end
    @order.update_attribute(:total, order_grand_total)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    order_grand_total = 0
    @order.order_items.each do |oi|
      order_grand_total += oi.total_price
    end
    @order.update_attribute(:total, order_grand_total)
    @order_items = @order.order_items
  end

  def pay
    @order = current_order
    amount = @order.total.round*100
    description = "Order From Courier USA LLC"

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:       customer.id,
      amount:         amount,
      description:    description,
      currency:       'usd',
      receipt_email:  customer.email,
      shipping:       {
        name: params[:stripeShippingName],
        address: {
          line1: params[:stripeShippingAddressLine1],
          city:  params[:stripeShippingAddressCity],
          state: params[:stripeShippingAddressState],
          postal_code: params[:stripeShippingAddressZip],
          country: params[:stripeShippingAddressCountry]
        }
      }
    )

    @message = {
        name: params[:stripeShippingName],
        email: customer.email,
        shipping_line1: params[:stripeShippingAddressLine1],
        shipping_city: params[:stripeShippingAddressCity],
        shipping_state: params[:stripeShippingAddressState],
        shipping_zip: params[:stripeShippingAddressZip],
        shipping_country: params[:stripeShippingAddressCountry],
        order_number: @order.id,
        order_items: @order.order_items
    }

    if charge
      ProductInquiryMailer.new_product_order(@message).deliver_now
      @order.update_attribute(:paid, true)
      @order.update_attribute(:track_package, 'Check back soon for package tracking information!')
      session[:order_id] = nil
      flash[:notice] = "You successfully paid your shipping charge! Check back soon for shipping information."
      redirect_to cart_path
    end
  rescue Stripe::CardError => e
    error = e.message
    redirect_to cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end

end
