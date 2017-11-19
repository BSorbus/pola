class Comment < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  include ActionView::Helpers::TextHelper

  # relations
  belongs_to :event
  belongs_to :user

  has_many :works, as: :trackable


  # validates
  validates :body, presence: true,
                    length: { minimum: 3 }

  # callbacks
  after_commit :send_notification, on: :create

  after_create_commit { self.log_work('create_comment') }


  def log_work(action = '', action_user_id = nil)
    trackable_url = "#{url_helpers.event_path(self.event)}"
    worker_id = action_user_id || self.user_id
    Work.create!(trackable_type: 'Event', trackable_id: self.event.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json(except: [:event_id, :user_id], include: {event: {only: [:id, :title]}, user: {only: [:id, :name, :email]}}))
  end

  def fullname
    "#{truncate(body, length: 50)}"
  end

  def send_notification
    StatusMailer.new_comment_email(self).deliver_later if self.event.accesses_users.any?
  end

end
