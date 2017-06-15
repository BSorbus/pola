class Project < ApplicationRecord
  has_many :accessorizations, dependent: :destroy
  has_many :accesses_users, :through => :accessorizations, source: :user
end
