puts " "
puts "#####  RUN - date_event.rb  #####"
puts " "

Event.all.each do |event|
  event.update_columns( created_at: event.errand.order_date )
end 


puts " "
puts "#####  END OF - date_event.rb  #####"
puts " "
