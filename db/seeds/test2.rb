puts " "
puts "#####  RUN - test2.rb  #####"
puts " "


#u = CreateAdminService.new.call_simple('bogdan.jarzab@uke.gov.pl', 'Bogdan Jarząb', '1qazXSW@')
u = User.last
#u.confirm

Role.all.each do |r|
  u.roles << r
  puts "ADD ROLE: #{r.name}   TO USER: #{u.name}"
end

puts " "
puts "#####  END OF - test2.rb  #####"
puts " "
