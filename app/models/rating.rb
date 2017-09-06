class Rating < ApplicationRecord
  belongs_to :event
  belongs_to :user

  # validates
  validates :event_id, presence: true,  
                      uniqueness: { message: "Ocena do tego zadania już istnieje" }  

  def fullname
    "[dotyczy zadania: #{self.event.fullname}, projekt: #{self.event.project.fullname}]"
  end
end
