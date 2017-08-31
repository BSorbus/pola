class Opinion < ApplicationRecord
  belongs_to :event
  belongs_to :user

  # validates
  validates :user_id, presence: true,  
                      uniqueness: { scope: [:project_id], :message => "jest już Twoja opinia do tego projektu" }  

  def fullname
    "Opinia do #{self.event.project.fullname}, autor: #{self.user.fullname}"
  end

end
