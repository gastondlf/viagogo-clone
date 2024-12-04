class ListingsController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :set_event, only: %i[index new create]
  before_action :set_listing, only: %i[show index]

  def index
    @listings = @event.listings.where(status: ['for_sale', 'tickets_available'])
  end

  def new
    @listing = Listing.new
    @ticket = @listing.tickets.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = @user
    @listing.event = @event
    @listing.status = "for_sale"
    if @listing.save!
      redirect_to new_ticket_path(@listing)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end
  def update
  end

  def destroy
    @listing.destroy
    redirect_to event_listings_path(@listing.event)
  end

  def my_listings
    @user = current_user
    @my_listings = Listing.where(user_id: @user, status: "for_sale")
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:description, :quantity, :user_id, :event_id, :ticket_category_id)
  end
end
