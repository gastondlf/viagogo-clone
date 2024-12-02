class TicketCategory < ApplicationRecord
  has_many :listings
  has_many :tickets, through: :listings

  validates :name, presence: true
end
