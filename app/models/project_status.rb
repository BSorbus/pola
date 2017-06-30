class ProjectStatus < ApplicationRecord

  # relations
  has_many :projects, dependent: :nullify

end
