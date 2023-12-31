class CartController < ApplicationController
  before_action :initialize_cart

  def show
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)

    if current_orderable && quantity > 0
      current_orderable.update(quantity: quantity)
    elsif current_orderable && quantity >= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product_id: @product.id, quantity:)
    end

    if turbo_frame_request?
      update_view_cart
    else
      redirect_to controller: :cart, action: :show
    end
  end

  def remove
    Orderable.find_by(id: params[:id]).destroy

    update_view_cart
  end

  def destroy
    Cart.destroy(@cart.id)
  end

  private

  def initialize_cart
    return if @cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end

  def update_view_cart
    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == "orderables"
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("cart",
                                 partial: "cart/cart",
                                 locals: { cart: @cart }),
            turbo_stream.replace("cart_count",
                                 partial: "shared/cart_count",
                                 locals: { cart: @cart })

          ]
        end
      else
        format.html
      end
    end
  end

end
