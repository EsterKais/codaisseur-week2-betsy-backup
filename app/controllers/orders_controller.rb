class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :submit_cart_items, only: [:new, :create]


  def show
    @order = current_user.orders.find(params[:id])
    @line_items = @order.line_items
  end


  def new
  end

  def create
    # todo
    # find out why there are no line_items and fix it
    # map through your line_items and calc your amount (quantity x price), than sum it up

    @order.save
    session[:cart] = {}
    redirect_to order_path(@order), notice: "Your order has been confirmed"
  end


private

  # def add_total_to_order
  #   @order.line_items.each do |total_price|
  #     @totalprice = @order.find(total_price: total_price)
  #   end
  # end


  def submit_cart_items
    @cart = session[:cart]
    @order = current_user.orders.build
    @cart.each do |product, quantity, price|
      @order.line_items.build(product_id: product, quantity: quantity, item_price: price)

      # @order.build(total_price: total)
    end
  end


  # def order_params
  #   params.require(:order).permit(:user_id, :order_number, :total_price)
  # end

  # def line_items_params
  #   params[:line_items].present? ? params.require(:line_items): []
  # end

end
