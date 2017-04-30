class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    if current_order.order_items.length > 0
      cart_path
    else
      root_path
    end
  end

end
