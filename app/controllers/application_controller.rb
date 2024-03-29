class ApplicationController < ActionController::Base
  before_action :prepare_meta_tags, if: -> { request.get? }

  def errors_to_flash(model)
    flash[:error] = errors_to_str(model, '<br>').html_safe
  end

  def errors_to_str(model, br)
    return if model.errors.empty?
    result ||= ""
    result += model.errors.full_messages.join(br)
    result
  end

  def prepare_meta_tags(options={})
    set_meta_tags build_meta_options(options)
  end

  def build_meta_options(options)
    site_name = "사회적협동조합 빠띠"
    title = ( options[:title].present? ? "#{view_context.strip_tags(options[:title])} | 빠띠" : "사회적협동조합 빠띠" )
    image = options[:image] || view_context.image_url('parti-ci.png')
    url = options[:url] || root_url
    description = view_context.strip_tags(options[:description]) || "빠띠는 민주주의를 혁신하고 사회의 여러 영역으로 확산하기 위해 툴킷, 플랫폼, 커뮤니티를 만드는 민주주의 활동가들의 협동조합입니다."
    {
      title:       title,
      reverse:     true,
      image:       image,
      description: description,
      keywords:    "사회적협동조합, 커뮤니티, 캠페인, 민주주의 개발, 공익 데이터, 민주주의 랩, 플랫폼, 협동조합, 빠띠, 우주당, 시민참여플랫폼, 민주주의 툴킷, 민주주의 캠페인, 정치참여, 정치, 민주주의, it, 툴킷, 정치캠페인, 더나은민주주의, digital democracy, 시민, 직접민주주의, 일상의 민주주의, 공공재, 공론장, 숙의민주주의",
      canonical:   url,
      twitter: {
        site_name: site_name,
        site: '@parti_coop',
        card: 'summary',
        title: title,
        description: description,
        image: image
      },
      og: {
        url: url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }
  end
end
