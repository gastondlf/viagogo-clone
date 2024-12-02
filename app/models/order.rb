class Order < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  has_many :listings, through: :users

  validates :status, presence: true
end
