class Project < ApplicationRecord
  has_many :accessorizations, dependent: :destroy
  has_many :accesses_users, :through => :accessorizations, source: :user

  def flat_assigned_users
    #self.accessorizations.order(:id).flat_map {|row| row.assigned_user_as }.join('<br>').html_safe
    Accessorization.includes(:user).where(project_id: self.id).order("users.name").flat_map {|row| row.assigned_user_as }.join('<br>').html_safe
  end

end
