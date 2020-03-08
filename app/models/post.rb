class Post < ApplicationRecord
  CATEGORIES = (
    (Solution::DICTIONARY.map { |solution_slug, solution_info| [solution_slug, solution_info[:title]] }) + [ [:data, '공공·공익 데이터'], [:lab, '민주주의 랩'], [:culture, '조직 문화'] ]
  ).to_h

  scope :recent, -> (limit_count = nil){
    posts = order(published_at: :desc)
    posts.limit(limit_count) if limit_count.present?
    posts
  }
  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished, -> { where(published_at: nil) }
  scope :by_category_slug, -> (category_slug){ where(category_slug: category_slug) }
  mount_uploader :cover, ImageUploader

  def published_at?
    published_at.present?
  end

  def category_title
    Post::CATEGORIES[self.category_slug.try(:to_sym)]
  end
end
