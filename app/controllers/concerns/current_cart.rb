module CurrentCart
  extend ActiveSupport::Concern
  
  private
  
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue e
    puts e.message
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end