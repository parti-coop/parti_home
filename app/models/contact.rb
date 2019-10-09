class Contact < ApplicationRecord
  validates :project_subject, presence: true
  validates :project_body, presence: true
  validates :contact_email, presence: true
  mount_uploader :attachment, DocumentUploader
end