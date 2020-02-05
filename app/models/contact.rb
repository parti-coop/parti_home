class Contact < ApplicationRecord
  validates :project_subject, presence: true
  validates :project_body, presence: true
  validates :project_why, presence: true
  validates :contact_email, presence: true
  mount_uploader :attachment, DocumentUploader

  serialize :solution_slugs, JSON

  scope :solution_slugs_array_in, ->(*some_solution_slugs) {
    result = self.none

    some_solution_slugs.map { |some_solution_slug| "%#{some_solution_slug}%" }.each do |like_solution_slug|
      result = result.or(self.where("solution_slugs like ?", like_solution_slug))
    end

    return result
  }

  before_save :trim_solution_slugs

  def self.ransackable_scopes(auth_object = nil)
    %i(solution_slugs_array_in)
  end

  private

  def trim_solution_slugs
    self.solution_slugs.reject! { |c| c.empty? }
  end
end