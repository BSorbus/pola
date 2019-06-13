class Flow < ApplicationRecord

  # relations
  belongs_to :business_trip
  belongs_to :business_trip_status
  belongs_to :business_trip_status_updated_user, :class_name => 'User'

end
