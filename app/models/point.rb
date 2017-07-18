class Point < ApplicationRecord
  enum status: [:inactive, :active]

  belongs_to :project
end
