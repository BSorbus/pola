class Attachment < ApplicationRecord
  belongs_to :attachmenable, polymorphic: true

  validates :attached_file, presence: true
  # validate :attached_file_size_validation

  # def attached_file_size_validation
  #   if attached_file.size > 1.megabytes
  #     errors.add(:base, "File should be less than 1MB")
  #   end
  # end

  def fullname
    "#{self.attached_file_identifier}"
  end

  mount_uploader :attached_file, AttachmentUploader
end
