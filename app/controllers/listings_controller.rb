class ListingsController < ApplicationController
  before_action :set_event, only: %i[index]
  before_action :set_listing, only: %i[show index]

  def index
    @listings = @event.listings.order(:ticket_category_id)
  end

  def new
    @user = current_user
    @listing = Listing.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
