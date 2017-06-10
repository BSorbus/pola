# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email


role = CreateRoleService.new.role_admin
puts 'CREATED ROLE: ' << role.name
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"

role = CreateRoleService.new.role_manager
puts 'CREATED ROLE: ' << role.name
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"
