class Project < ApplicationRecord

  # relations
  has_many :accessorizations, dependent: :destroy, index_errors: true
  has_many :accesses_users, :through => :accessorizations, source: :user

  # validates
  validates :number, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }

  accepts_nested_attributes_for :accessorizations, reject_if: :all_blank, allow_destroy: true

  def flat_assigned_users
    #self.accessorizations.order(:id).flat_map {|row| row.assigned_user_as }.join('<br>').html_safe
    Accessorization.includes(:user).where(project_id: self.id).order("users.name").flat_map {|row| row.assigned_user_as }.join('<br>').html_safe
  end

end
