class PointFile < ApplicationRecord
  enum status: [:inactive, :active]

  belongs_to :project

  def fullname
    "#{self.load_file}"
  end

end
