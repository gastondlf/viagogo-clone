class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :ticket_category
  belongs_to :event
end
