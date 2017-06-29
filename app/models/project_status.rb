class ProjectStatus < ApplicationRecord
  has_many :projects, dependent: :nullify

end
