class ApplicationController < ActionController::Base
  before_action :get_cart

  def get_cart
    if session[:cart_id] && @cart.nil?
      @cart = Cart.find_by(id: session[:cart_id])
    end
  end
end
