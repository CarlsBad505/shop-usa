class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  # Use this method to display orders on the Admin Page
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
       # Do Something / Flash Message
    else
       # Do Something / Flash Message
    end
    
  end

  def edit
  end

  def update
  end

  def destroy
    @order = current_user.orders.find(params[:id])
    if @order.destroy
      # Do Something / Flash Message
    else
      # Do Something / Flash Message
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:description, :shipping_charge, :track_package)
  end
end
