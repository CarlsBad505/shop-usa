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
    shipping_charge = 0
    @order.order_items.each do |oi|
      shipping_charge += oi.product.shipping
    end
    grand_total = amount + shipping_charge.round*100
    description = "Order From Courier USA LLC"

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:       customer.id,
      amount:         grand_total,
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
        order_items: @order.order_items,
        guest: current_user ? "No" : "Yes"
    }

    if charge
      ProductInquiryMailer.new_product_order(@message).deliver_now
      @order.update_attribute(:paid, true)
      @order.update_attribute(:track_package, 'Check back soon for package tracking information!')
      @order.update_attribute(:user_id, current_user.id) unless !current_user
      session[:order_id] = nil
      redirect_to cart_path if !current_user
      redirect_to myorders_path if current_user
      flash[:notice] = "Success, your receipt will be emailed shortly!"
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
