class Ticket < ApplicationRecord
  belongs_to :listing

  has_many :orders

  validates :price, presence: true
  validates :status, presence: true
  validates :ticket_number, uniqueness: true, presence: true
end
