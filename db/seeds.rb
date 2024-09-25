# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Tag.destroy_all

tags = %w[
  Technology
  Science
  Health
  Travel
  Food
  Lifestyle
  Education
  Finance
  Sports
  Entertainment
  Fashion
  Music
  Art
  History
  Nature
]

tags.each do |tag|
  Tag.create(name: tag)
end

puts "Created #{Tag.count} tags."





# Create default user
default_user = User.create(
  name: "Default User",
  email: "default_user@example.com",
  password: "secret",
  password_confirmation: "secret"
)

puts "Created default user: #{default_user.email}"
