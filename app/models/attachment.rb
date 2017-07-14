class Attachment < ApplicationRecord
  belongs_to :attachmenable, polymorphic: true

  mount_uploader :attached_file, AttachmentUploader
end
