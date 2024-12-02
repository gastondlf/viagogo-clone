class Event < ApplicationRecord
  has_many :listings
  has_many :tickets, through: :listings
end
