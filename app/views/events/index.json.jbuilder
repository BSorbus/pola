json.array!(@events) do |event|
  json.title event.title
  json.allDay event.all_day
  json.start event.start_date
  json.end event.end_date
  json.color event.color_value 
  json.url event_url(event, format: :html)
end
