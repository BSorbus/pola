class EventStatus < ApplicationRecord

  EVENT_STATUS_OPENED = 1
  EVENT_STATUS_VERIFICATION = 2
  EVENT_STATUS_CLOSED = 3


  # relations
  has_many :events, dependent: :nullify

  # validates
  validates :name, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }

  # scope :can_change, -> { where(role: 'administrator') }
  scope :status_can_change, -> { where(id: [EVENT_STATUS_OPENED, EVENT_STATUS_VERIFICATION]) }

end