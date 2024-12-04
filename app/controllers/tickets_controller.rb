class TicketsController < ApplicationController
  before_action :set_listing, only: [:destroy, :create, :new]
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

  def new
  end
  # this action is called in the listing page via a create new ticket button
  def create
    @tickets = params[:tickets].values.map do |ticket_params|
      ticket = @listing.tickets.new(ticket_params.permit(:ticket_number, :price))
      ticket.status = "for_sale"
      ticket
    end
    if @tickets.all?(&:valid?)
      @tickets.each(&:save)
      redirect_to event_listings_path(@listing.event)
    else
      errors = @tickets.map.with_index { |t, index| "Ticket #{index + 1}: #{t.errors.full_messages.join(", ")}" }
      flash.notice = "Tickets not created, Make sure you have all the fields right, #{errors}"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.required(:ticket).permit(:ticket_number, :price, :status)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
