class Comment < ApplicationRecord

  include ActionView::Helpers::TextHelper

  belongs_to :event
  belongs_to :user

  validates :body, presence: true,
                    length: { minimum: 3 }

  # callbacks
  after_commit :send_notification, on: :create

  def fullname
    "#{truncate(body, length: 50)}"
  end

  def send_notification
    StatusMailer.new_comment_email(self).deliver_later if self.event.accesses_users.any?
  end

end
