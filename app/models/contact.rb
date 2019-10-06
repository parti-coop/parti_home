class Contact < ApplicationRecord
  validates :project_subject, presence: true
  validates :contact_email, presence: true
end