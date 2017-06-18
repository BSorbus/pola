class Accessorization < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  belongs_to :role #, -> { only_not_special }

  def assigned_user_as
    "#{self.user.present? ? self.user.name : ''} - #{self.role.present? ? self.role.name : ''}"
  end


end
