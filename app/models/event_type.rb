class EventType < ApplicationRecord

  # relations
  has_many :events, dependent: :nullify

end
