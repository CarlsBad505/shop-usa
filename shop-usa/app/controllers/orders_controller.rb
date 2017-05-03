class OrdersController < ApplicationController
  before_action :authenticate_user!

  # Use this method to display orders on the Admin Page
  def index
    @orders = Order.all
  end

  def custom_inquiry
    @custom_orders = Order.all.where(custom: true).where(paid: false)
  end

  # Use this method to display orders who belong to a specific user
  def user_index
    @myorders = current_user.orders.where(paid: true)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  # Use this method for admins to create charges and orders, must link to a specific user
  def create
    begin
      chosen_user = find_user(order_params[:user_id])
      @order = chosen_user.orders.create(order_params)

      if @order.save
         flash[:notice] = "Order was created successfully!"
         redirect_to orders_path
      else
         flash[:error] = "Error: Make sure the user exists or type in the correct user email."
      end
    rescue
      flash[:error] = "Error: Make sure the user exists or type in the correct user email."
      redirect_to new_order_path
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.assign_attributes(order_params)
    if @order.save
      flash[:notice] = "The order was updated successfully!"
      redirect_to orders_path
    else
      flash[:error] = "Make sure you didn't leave any required fields blank."
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      flash[:notice] = "The order was deleted successfully!"
      redirect_to orders_path
    else
      flash[:error] = "Something went wrong, please try again."
      render :edit
    end
  end

  def pay
    @order = Order.find(params[:id])
    shipping_amount = @order.shipping_charge.round*100
    item_amount = @order.total.round*100
    total_amount = shipping_amount + item_amount
    description = @order.description

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => total_amount,
      :description => description,
      :currency    => 'usd',
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
      description: @order.description,
      shipping_amount: @order.shipping_charge,
      item_amount: @order.total,
      total_amount: @order.total + @order.shipping_charge
    }

    if charge
      ProductInquiryMailer.new_product_order(@message).deliver_now
      @order.update_attribute(:paid, true)
      @order.update_attribute(:track_package, 'Check back soon for package tracking information!')
      redirect_to myorders_path
      flash[:notice] = "Success, your receipt will be emailed shortly!"
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to myorders_path
  end

  private

  def find_user(email)
    user = User.where(email: email)
    user_id = user[0][:id]
    return User.find(user_id)
  end

  def order_params
    params.require(:order).permit(:description, :shipping_charge, :track_package, :user_id, :custom, :total)
  end
end
