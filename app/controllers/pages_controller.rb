class PagesController < ApplicationController
  def home
    @posts = fetch_what_we_do().limit(1 + 2 * 4)
  end

  def home_what_we_do
    @posts = fetch_what_we_do().limit(1 + 2 * 4)
    render 'pages/home/what_we_do'
  end

  def what_we_do
    @posts = fetch_what_we_do().page(params[:page]).per(3*10)

    prepare_meta_tags(title: '소식', description: '민주주의를 혁신하고 일상과 세상에 민주주의를 확산하기 위해 저희가 하는 일을 블로그로 소개합니다.', url: what_we_do_url)
  end

  def marketing
  end

  def privacy
  end

  def privacy_revisions_v1
    render 'pages/privacy_revisions/v1'
  end

  def subscribe_reports
    outcome = MailingSubscribe.run(name: params[:name], email: params[:email])
    if outcome.valid?
      flash[:success] = '구독 확인 이메일을 발송했습니다. 보내드린 이메일을 확인하면 구독이 완료됩니다.'
    else
      messages = outcome.errors.full_messages.join('. ')
      logger.error messages

      if outcome.errors.added?(:base, :server)
        flash[:error] = messages
      else
        flash[:error] = '민주주의 리포트 구독이 실패했습니다. contact@parti.coop로 구독 신청 메일을 보내 주세요.'
      end
    end
  end

  private

  def fetch_what_we_do
    @posts = Post.published.recent

    category_slug = params[:category_slug]
    @posts = @posts.by_category_slug(category_slug) if category_slug.present?
    @posts
  end
end