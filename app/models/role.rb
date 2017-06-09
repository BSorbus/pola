class Role < ApplicationRecord
  has_and_belongs_to_many :users

  # validates
  validates :name, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }


  def fullname_and_id
    "#{name} (#{id})"
  end
  
end
