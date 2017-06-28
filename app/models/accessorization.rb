class Accessorization < ApplicationRecord

  # relations
  belongs_to :project
  belongs_to :user
  belongs_to :role #, -> { only_not_special }

  # validates
  validates :user_id, presence: true,  
                      uniqueness: { :scope => [:project_id], :message => "jest już przypisany do tego projektu" }  

  #validates_presence_of :project
  #validates_presence_of :user
  #validates_presence_of :role

end
