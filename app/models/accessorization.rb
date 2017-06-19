class Accessorization < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  belongs_to :role #, -> { only_not_special }


  #validates_presence_of :project
  #validates_presence_of :user
  #validates_presence_of :role

  def assigned_user_as
    "#{self.user.present? ? self.user.name : ''} - #{self.role.present? ? self.role.name : ''}"
  end


end
