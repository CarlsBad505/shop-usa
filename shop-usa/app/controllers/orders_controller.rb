class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  # Use this method to display orders on the Admin Page
  def index
    @orders = Order.all
  end
  
  # Use this method to display orders who belong to a specific user
  def user_index
    @myorders = current_user.orders
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
  
  private
  
  def find_user(email)
    user = User.where(email: email)
    user_id = user[0][:id]
    return User.find(user_id)
  end
  
  def order_params
    params.require(:order).permit(:description, :shipping_charge, :track_package, :user_id)
  end
end
