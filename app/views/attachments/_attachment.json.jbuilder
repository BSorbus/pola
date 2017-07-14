json.extract! attachment, :id, :attachmenable_id, :attachmenable_type, :attached_file, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
