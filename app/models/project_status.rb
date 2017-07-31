class ProjectStatus < ApplicationRecord

  # relations
  has_many :projects, dependent: :nullify

  # validates
  validates :name, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }

end
