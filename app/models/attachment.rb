class Attachment < ApplicationRecord
  include Rails.application.routes.url_helpers

  # relations
  belongs_to :user
  belongs_to :attachmenable, polymorphic: true

  # validates
  validates :attached_file, presence: true, file_size: { in: 1.byte..50.megabyte,
                                         message: 'must be within %{min} and %{max}' }

  # callbacks
  after_create_commit { self.log_work('upload') }


  def log_work(action)
    parent_class_name = self.attachmenable.class.to_s # ex. 'Project'
    url_for_parent = url_for(only_path: true, controller: parent_class_name.pluralize.downcase, action: 'show', id: self.attachmenable.id)
    Work.create!(trackable_type: "#{parent_class_name}", trackable_id: self.attachmenable.id, trackable_url: url_for_parent, action: "#{action}", user: self.user, 
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

  mount_uploader :attached_file, AttachmentUploader
end
