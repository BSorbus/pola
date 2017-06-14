class Role < ApplicationRecord

  # relations
  has_and_belongs_to_many :users
  has_many :accessorizations

  # validates
  validates :name, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }

  scope :only_not_special, -> { where(special: false) }  
end
