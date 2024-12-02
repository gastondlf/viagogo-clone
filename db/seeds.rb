# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Order.destroy_all
Ticket.destroy_all
Listing.destroy_all
Event.destroy_all
TicketCategory.destroy_all
User.destroy_all

# Create 5 users with Faker
users = 5.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone
  )
end

# Create 4 ticket categories with Faker
ticket_categories = 4.times.map do
  TicketCategory.create!(
    name: Faker::Commerce.unique.department(max: 1) # Generates unique, short names
  )
end

# Create 10 events with Faker
events = 10.times.map do
  Event.create!(
    name: Faker::Music::RockBand.name,
    date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
    location: Faker::Address.city,
    capacity: rand(100..1000)
  )
end

# Create listings with the desired distribution of statuses
listings = []
tickets = []

events.each do |event|
  3.times do
    user = users.sample
    ticket_category = ticket_categories.sample
    quantity = rand(1..5)

    # Determine listing status based on desired distribution
    listing_status = case rand(1..100)
                     when 1..20
                       "sold_out" # 20% chance
                     when 21..70
                       "tickets_available" # 50% chance
                     else
                       "for_sale" # 30% chance
                     end

    listing = Listing.create!(
      description: "#{Faker::Lorem.sentence} for #{event.name}",
      status: listing_status,
      quantity: listing_status == "sold_out" ? 0 : quantity,
      user: user,
      event: event,
      ticket_category: ticket_category
    )
    listings << listing

    # Create tickets for each listing based on the listing status
    if listing_status == "sold_out"
      quantity.times do
        tickets << Ticket.create!(
          ticket_number: Faker::Alphanumeric.unique.alphanumeric(number: 10).upcase,
          price: Faker::Commerce.price(range: 50.0..500.0),
          status: "sold", # All tickets are sold
          listing: listing
        )
      end
    else
      quantity.times do |i|
        ticket_status = listing_status == "for_sale" ? "for_sale" : %w[for_sale sold].sample
        tickets << Ticket.create!(
          ticket_number: Faker::Alphanumeric.unique.alphanumeric(number: 10).upcase,
          price: Faker::Commerce.price(range: 50.0..500.0),
          status: ticket_status,
          listing: listing
        )
      end
    end
  end
end

# Create orders for each sold ticket
sold_tickets = tickets.select { |t| t.status == "sold" }

sold_tickets.each do |ticket|
  user = users.sample

  Order.create!(
    status: "completed", # 1 - completed
    user: user,
    ticket: ticket
  )
end

puts "Seed data with matching orders and sold tickets created successfully!"
