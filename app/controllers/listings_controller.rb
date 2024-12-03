class ListingsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  def index
    @listings = Listing.order(:ticket_category_id)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
