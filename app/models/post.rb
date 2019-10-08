class Post < ApplicationRecord
  SOLUTIONS = [
    {
      slug: :demos,
      path_text: :solutions_demos_path,
      title: '기관&middot시민 참여 플랫폼',
      subtitle: '일상 곳곳을 민주적으로',
      image_path: 'solutions/card-demos.png'
    }, {
      slug: :org,
      path_text: :solutions_org_path,
      title: '시민자치 커뮤니티',
      subtitle: '일상 곳곳을 민주적으로',
      image_path: 'solutions/card-org.png'
    }, {
      slug: :campaign,
      path_text: :solutions_campaign_path,
      title: '시민주도 캠페인',
      subtitle: '일상 곳곳을 민주적으로',
      image_path: 'solutions/card-campaign.png'
    }, {
      slug: :soft,
      path_text: :solutions_soft_path,
      title: '디지털 솔루션',
      subtitle: '일상 곳곳을 민주적으로',
      image_path: 'solutions/card-soft.png'
    }
  ]

  SOLUTIONS_MAP = Hash[Post::SOLUTIONS.map { |solution| [ solution[:slug], solution ] }]

  scope :recent, -> (limit_count = nil){
    posts = order(published_at: :desc)
    posts.limit(limit_count) if limit_count.present?
    posts
  }
  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished, -> { where(published_at: nil) }
  scope :by_solution_slug, -> (solution_slug){ where(solution_slug: solution_slug) }
  mount_uploader :cover, ImageUploader

  def published_at?
    published_at.present?
  end

  def solution_text
    SOLUTIONS_MAP[self.solution_slug.try(:to_sym)].try(:[], :title)
  end
end