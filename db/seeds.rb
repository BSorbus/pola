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

role = CreateRoleService.new.role_publisher
puts 'CREATED ROLE: ' << role.name
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"

role = CreateRoleService.new.role_writer
puts 'CREATED ROLE: ' << role.name
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"




# Simple User 1
user = CreateAdminService.new.call_simple('simple1.proca@uke.gov.pl', 'Simple User 1', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email
role = Role.find_by(name: 'Użytkownik Opiniujący')
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"
role = Role.find_by(name: 'Użytkownik Opiniujący i Publikujący')
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"


# Simple User 2
user = CreateAdminService.new.call_simple('simple2.proca@uke.gov.pl', 'Simple User 2', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email
role = Role.find_by(name: 'Użytkownik Opiniujący')
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"
role = Role.find_by(name: 'Użytkownik Opiniujący i Publikujący')
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"

# Simple User 3
user = CreateAdminService.new.call_simple('simple3.proca@uke.gov.pl', 'Simple User 3', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email
role = Role.find_by(name: 'Użytkownik Opiniujący')
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"
role = Role.find_by(name: 'Użytkownik Opiniujący i Publikujący')
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"

# Simple User 4
user = CreateAdminService.new.call_simple('simple4.proca@uke.gov.pl', 'Simple User 4', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email
role = Role.find_by(name: 'Użytkownik Opiniujący')
user.roles << role
puts "ADD ROLE: #{role.name}   TO USER: #{user.email}"




# example projects
project = Project.create(number: 'Project 1')
puts 'CREATED SIMPLE PROJECT: ' << project.number

project = Project.create(number: 'Project 2')
puts 'CREATED SIMPLE PROJECT: ' << project.number

project = Project.create(number: 'Project 3')
puts 'CREATED SIMPLE PROJECT: ' << project.number


# accessorizations
simple1 = User.find_by(email: 'simple1.proca@uke.gov.pl')
simple2 = User.find_by(email: 'simple2.proca@uke.gov.pl')
simple3 = User.find_by(email: 'simple3.proca@uke.gov.pl')
simple4 = User.find_by(email: 'simple4.proca@uke.gov.pl')

writer = Role.find_by(name: 'Użytkownik Opiniujący')
publisher = Role.find_by(name: 'Użytkownik Opiniujący i Publikujący')
special = Role.find_by(name: 'Administrator Biznesowy')

project = Project.find_by(number: 'Project 1')
a = project.accessorizations.create(user: simple1, role: publisher)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple2, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple3, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"

project = Project.find_by(number: 'Project 2')
a = project.accessorizations.create(user: simple1, role: publisher)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple2, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple3, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"

project = Project.find_by(number: 'Project 3')
a = project.accessorizations.create(user: simple4, role: publisher)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple1, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple2, role: special)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
