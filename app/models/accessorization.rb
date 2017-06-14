class Accessorization < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  belongs_to :role, -> { only_not_special }
end
