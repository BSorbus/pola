class ErrandType < ApplicationRecord

  # relations
  has_many :errands, dependent: :nullify

  # validates
  validates :name, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }
end
