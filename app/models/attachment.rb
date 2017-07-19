class Attachment < ApplicationRecord
  belongs_to :attachmenable, polymorphic: true

  validates :attached_file, presence: true, file_size: { in: 1.byte..10.megabyte,
                                         message: 'must be within %{min} and %{max}' }

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
