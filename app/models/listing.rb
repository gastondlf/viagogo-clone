class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :ticket_category
  belongs_to :event

  has_many :tickets
  has_many :orders, through: :tickets

  validates :quantity, presence: true
  validates :status, presence: true

  def human_status
    status.humanize.split(" ").map(&:capitalize).join(" ")
  end
end
