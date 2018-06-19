class Attachment < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  # relations
  belongs_to :user
  belongs_to :attachmenable, polymorphic: true, counter_cache: true, touch: true

  # validates
  validates :attached_file, presence: true, file_size: { in: 1.byte..150.megabyte }

  # callbacks
  after_commit :send_notification, on: [:create, :update], if: "attachmenable_type === 'Event'"

  after_create_commit { self.log_work('upload_attachment') }
  after_update_commit { self.log_work('update') }

  mount_uploader :attached_file, AttachmentUploader


  def log_work(action = '', action_user_id = nil)
    trackable_url = url_helpers(only_path: true, controller: self.attachmenable.class.to_s.pluralize.downcase, action: 'show', id: self.attachmenable.id)
    worker_id = action_user_id || self.user_id
    Work.create!(trackable_type: "#{self.attachmenable.class.to_s}", trackable_id: self.attachmenable.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json(except: [:user_id], include: {user: {only: [:id, :name, :email]}}))
  end


  # validate :attached_file_size_validation

  # def attached_file_size_validation
  #   if attached_file.size > 1.megabytes
  #     errors.add(:base, "File should be less than 1MB")
  #     throw :abort 
  #   end
  # end

  def send_notification
    #StatusMailer.new_update_event_email(self).deliver_later if self.accesses_users.any?
    StatusMailer.add_attachment_to_event_email(self.attachmenable).deliver_later if self.attachmenable.accesses_users.any?
  end

  def fullname
    "#{self.attached_file_identifier}"
  end

end
