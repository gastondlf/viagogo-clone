class OrdersController < ApplicationController
  before_action :set_user
  before_action :set_listing, only: [:new]

  # this is basically the order confirmation and checkout page
  # this page needs to take payment information, 
  # need some way to pass ticket ids to this action
  # i'm assuming that there is a purchase button on the listing page
  # that will fire this action...
  def new
    @tickets = @listing.tickets.where(status: "for_sale")   # assumes ticket quantity number passed from listings page form and all are the same category
    @order = @user.orders.new
    @total_price = @tickets.sum { |ticket| ticket.price }
    @event = @tickets.first.listing.event
    @category = @tickets.first.listing.ticket_category   # I'm assuming that all tickets in a listing are the same category 
  end
  
  def create 
    listing_id = params[:order][:listing_id]
    quantity = params[:order][:ticket_quantity].to_i
    @tickets = Listing.find(listing_id).tickets.limit(quantity)
    @tickets.each do |ticket| 
      @order = @user.orders.new(status: "sold", ticket_id: ticket.id)      
      ticket.update_columns(status: 'sold')
      @order.save
    end     # updating the ticket status when a new order is created
    redirect_to my_orders_path(@user)
  end

  # so this will show a list of orders 
  # not totally sure about this includes method but I believe this give me access
  # orders via relationship to tickects and listings thru tickets and events thru listings...
  def my_orders
    @orders = @user.orders
    @grouped_orders = @orders.includes(ticket: { listing: :event }).group_by do |order|
      [order.ticket.listing.event.name, order.ticket.listing.event.date]
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :ticket_id, :listing_id)
  end
end
