class ProductsController < ApplicationController
  def index
    @message = Message.new
    @products = Product.all
    @order_item = current_order.order_items.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      ProductInquiryMailer.new_product_inquiry(@message).deliver_now
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:first_name, :last_name, :email_address, :phone, :url, :note)
  end
end
