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

role = CreateRoleService.new.role_publisher
puts 'CREATED ROLE: ' << role.name

role = CreateRoleService.new.role_writer
puts 'CREATED ROLE: ' << role.name



# Simple User 1
user = CreateAdminService.new.call_simple('mateusz.falenta@uke.gov.pl', 'Mateusz Falenta', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email

# Simple User 2
user = CreateAdminService.new.call_simple('pawel.mielczarek@uke.gov.pl', 'Paweł Mielczarek', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email

# Simple User 3
user = CreateAdminService.new.call_simple('mariusz.krupa@uke.gov.pl', 'Mariusz Krupa', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email

# Simple User 4
user = CreateAdminService.new.call_simple('marcin.dudek@uke.gov.pl', 'Marcin Dudek', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email

# Simple User 5
user = CreateAdminService.new.call_simple('piotr.majewski@uke.gov.pl', 'Piotr Majewski', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email

# Simple User 6
user = CreateAdminService.new.call_simple('bogdan.jarzab@uke.gov.pl', 'Bogdan Jarząb', '1qazXSW@')
puts 'CREATED SIMPLE USER: ' << user.email



# project_statuses
project_status = ProjectStatus.find_or_create_by!(name: "zarejestrowany")
ProjectStatus.find_or_create_by!(name: "opiniowany")
ProjectStatus.find_or_create_by!(name: "zaopiniowany i podpisany")
ProjectStatus.find_or_create_by!(name: "opublikowany")
ProjectStatus.find_or_create_by!(name: "odwołanie - zarejestrowany")
ProjectStatus.find_or_create_by!(name: "odwołanie - opiniowany")
ProjectStatus.find_or_create_by!(name: "odwołanie - zaopiniowany i podpisany")
ProjectStatus.find_or_create_by!(name: "odwołanie - opublikowany")


# example customers
customer1 = Customer.create(name: 'Customer1')
puts 'CREATED CUSTOMER: ' << customer1.name

customer2 = Customer.create(name: 'Customer2')
puts 'CREATED CUSTOMER: ' << customer2.name

customer3 = Customer.create(name: 'Customer3')
puts 'CREATED CUSTOMER: ' << customer3.name

customer4 = Customer.create(name: 'Customer4')
puts 'CREATED CUSTOMER: ' << customer4.name

customer5 = Customer.create(name: 'Customer5')
puts 'CREATED CUSTOMER: ' << customer4.name

customer6 = Customer.create(name: 'Customer6')
puts 'CREATED CUSTOMER: ' << customer4.name

customer7 = Customer.create(name: 'Customer7')
puts 'CREATED CUSTOMER: ' << customer4.name

customer8 = Customer.create(name: 'Customer8')
puts 'CREATED CUSTOMER: ' << customer4.name


# example projects
project = Project.create(number: '1/2017', project_status: project_status, customer: customer1)
puts 'CREATED SIMPLE PROJECT: ' << project.number

project = Project.create(number: '2/2017', project_status: project_status, customer: customer2)
puts 'CREATED SIMPLE PROJECT: ' << project.number

project = Project.create(number: '3/2017', project_status: project_status, customer: customer2)
puts 'CREATED SIMPLE PROJECT: ' << project.number

project = Project.create(number: '4/2017', project_status: project_status, customer: customer3)
puts 'CREATED SIMPLE PROJECT: ' << project.number

project = Project.create(number: '5/2017', project_status: project_status, customer: customer4)
puts 'CREATED SIMPLE PROJECT: ' << project.number


# accessorizations
simple1 = User.find_by(email: 'mateusz.falenta@uke.gov.pl')
simple2 = User.find_by(email: 'pawel.mielczarek@uke.gov.pl')
simple3 = User.find_by(email: 'mariusz.krupa@uke.gov.pl')
simple4 = User.find_by(email: 'marcin.dudek@uke.gov.pl')
simple5 = User.find_by(email: 'piotr.majewski@uke.gov.pl')

writer = Role.find_by(name: 'Użytkownik Opiniujący')
publisher = Role.find_by(name: 'Użytkownik Opiniujący i Publikujący')

project = Project.find_by(number: '1/2017')
a = project.accessorizations.create(user: simple1, role: publisher)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple2, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple3, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"

project = Project.find_by(number: '2/2017')
a = project.accessorizations.create(user: simple1, role: publisher)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple2, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple3, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"

project = Project.find_by(number: '3/2017')
a = project.accessorizations.create(user: simple4, role: publisher)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple1, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple2, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"

project = Project.find_by(number: '4/2017')
a = project.accessorizations.create(user: simple3, role: publisher)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple4, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
a = project.accessorizations.create(user: simple5, role: writer)
puts "ADD #{a.user.email} TO #{a.project.number} AS #{a.role.name}"
