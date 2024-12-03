class OrdersController < ApplicationController
  before_action :set_user

  # this is basically the order confirmation and checkout page
  # this page needs to take payment information, 
  # need some way to pass ticket ids to this action
  # i'm assuming that there is a purchase button on the listing page
  # that will fire this action...
  # potential problem with the orders table... there is only one ticket id stored there...
  # each order can only be for one ticket then?
  def new
    @tickets = Ticket.where(id: params[:ticket_ids])
    @order = @user.orders.new
    @total_price = @tickets.sum { |ticket| ticket.price }
    @event = @tickets.first.listing.event
    @category = @tickets.first.listing.ticket_categories   # I'm assuming that all tickets in a listing are the same category 
  end
  
  def create
    @order = @user.orders.new(order_params)
    @order.save
    tickets.each do |ticket|
      ticket.update(status: 'sold')     # updating the ticket status when a new order is created
    redirect_to my_orders_path(@user)
    end
  end

  # so this will show a list of orders 
  # not totally sure about this includes method but I believe this give me access
  # orders relationship to tickects and listings thru tickets and events thru listings...
  def my_orders
    @orders = @user.orders.includes(tickets: { listing: :event })
  end

  private

  def set_user
    @user = current_user
  end

  def order_params
    params.require(:order).permit(:status, :ticket_id)
  end
end
