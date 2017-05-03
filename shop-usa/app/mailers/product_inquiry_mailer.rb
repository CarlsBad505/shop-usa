class ProductInquiryMailer < ApplicationMailer
  default from: "noreply@courierusallc.com"
  # default to: "peter.sidles@courierusallc.com"
  default to: "orders@courierusallc.com"
  # default to: "carl@tabrific.com"

  def new_product_inquiry(message)
    @message = message
    mail subject: "New Product Inquiry"
  end

  def new_commercial_inquiry(message)
    @message = message
    mail subject: "New Commercial Inquiry"
  end

  def new_product_order(message)
    @message = message
    mail subject: "New Order Awaiting Fullfilment"
  end
end
