class Project < ApplicationRecord
  has_many :accessorizations
  has_many :users, :through => :accessorizations
end
