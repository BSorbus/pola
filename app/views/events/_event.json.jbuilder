json.extract! event, :id, :title, :all_day, :start_date, :end_date, :created_at, :updated_at
json.url event_url(event, format: :json)
