json.extract! event, :id, :title, :all_day, :start_date, :end_date, :color, :url_action, :created_at, :updated_at
json.url event_url(event, format: :json)
