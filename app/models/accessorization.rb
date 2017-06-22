class Accessorization < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  belongs_to :project
  belongs_to :user
  
  belongs_to :role #, -> { only_not_special }


  #validates_presence_of :project
  #validates_presence_of :user
  #validates_presence_of :role

  def assigned_user_as
    # "<a href=#{url_helpers.user_path(self.user)}>#{self.user.name}</a>"
    # "<a href=#{url_helpers.role_path(self.role)}>#{self.role.name}</a>"
    "#{self.user.present? ? "<a href=#{url_helpers.user_path(self.user)}>#{self.user.name}</a>" : ''}" +
    " - #{self.role.present? ? "<a href=#{url_helpers.role_path(self.role)}>#{self.role.name}</a>" : ''}"
  end

  def assigned_project_as
    "#{self.project.present? ? "<a href=#{url_helpers.project_path(self.project)}>#{self.project.number}</a>" : ''}" +
    " - #{self.role.present? ? "<a href=#{url_helpers.role_path(self.role)}>#{self.role.name}</a>" : ''}"
 
  end

end
