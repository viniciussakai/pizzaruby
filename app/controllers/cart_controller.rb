class CartController < ApplicationController
  before_action :initialize_cart

  def show
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)

    if current_orderable && quantity > 0
      current_orderable.update(quantity:)
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product_id: @product.id, quantity:)
    end

  end

  def remove
    Orderable.find_by(id: params[:id]).destroy
  end

  def destroy
    Cart.destroy(@cart.id)
  end

  private

  def initialize_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end

end
