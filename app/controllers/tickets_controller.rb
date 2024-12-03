class TicketsController < ApplicationController
  before_action :set_listing, only: [:destroy, :create]
  before_action :set_ticket, only: [:update, :destroy]

  # this action is being called when a user makes an order via 
  # make payment button on the new order page
  # it changes the ticket[:status] to sold 
  def update
    @ticket.update(ticket_params)
    redirect_to my_orders_path(current_user)
  end

  # this action is called on the listing page via a delete ticket button
  def destroy
    @ticket.destroy
    redirect_to listing_path(@listing)
  end

  # this action is called in the listing page via a create new ticket button
  def create
    @ticket = @listing.tickets.new(ticket_params)
    @ticket.save
    redirect_to listing_path(@listing)
  end

  private

  def ticket_params
    params.required(:ticket).permit(:ticket_number, :price, :status)
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
