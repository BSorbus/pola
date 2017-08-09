class Comment < ApplicationRecord

  include ActionView::Helpers::TextHelper

  belongs_to :event
  belongs_to :user

  validates :body, presence: true,
                    length: { minimum: 3 }

  def fullname
    "#{truncate(body, length: 50)}"
  end

end
