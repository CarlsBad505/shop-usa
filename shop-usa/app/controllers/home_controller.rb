class HomeController < ApplicationController
  def index
  end

  def how_it_works
  end

  def enterprise
    @message = Message.new
  end

  def contact
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      ProductInquiryMailer.new_commercial_inquiry(@message).deliver_now
    end
    respond_to do |format|
      format.js
    end
  end

  def guest
  end

  private

  def message_params
    params.require(:message).permit(:first_name, :last_name, :email_address, :url, :phone, :note)
  end

end
