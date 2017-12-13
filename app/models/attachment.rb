class Attachment < ApplicationRecord
  delegate :url_for, to: 'Rails.application.routes'

  # relations
  belongs_to :user
  belongs_to :attachmenable, polymorphic: true

  # validates
  validates :attached_file, presence: true, file_size: { in: 1.byte..150.megabyte,
                                         message: 'must be within %{min} and %{max}' }

  # callbacks
  after_create_commit { self.log_work('upload_attachment') }

  mount_uploader :attached_file, AttachmentUploader


  def log_work(action = '', action_user_id = nil)
    trackable_url = url_for(only_path: true, controller: self.attachmenable.class.to_s.pluralize.downcase, action: 'show', id: self.attachmenable.id)
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

  def fullname
    "#{self.attached_file_identifier}"
  end

end
