class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable,
         :timeoutable, 
         :trackable, 
         :validatable,
         :lockable

  # relations
  has_and_belongs_to_many :roles

  has_many :accessorizations, dependent: :nullify, index_errors: true
  has_many :accesses_projects, :through => :accessorizations, source: :project

  accepts_nested_attributes_for :accessorizations, reject_if: :all_blank, allow_destroy: true

end
