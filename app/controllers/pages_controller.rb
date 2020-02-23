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
  end

  def marketing
  end

  def privacy
  end

  def privacy_revisions_v1
    render 'pages/privacy_revisions/v1'
  end

  def subscribe_reports
    outcome = MailingSubscribe.run(name: params[:name], email: [:email])
    if outcome.valid?
      flash[:success] = "구독 확인 이메일을 발송했습니다. 보내드린 이메일을 확인하면 구독이 완료됩니다."
    else
      logger.error outcome.errors.full_messages.join('. ')
      flash[:error] = "알 수 없는 오류가 발생했습니다. help@parti.xyz로 구독 신청 메일을 보내 주세요."
    end
  end

  private

  def fetch_what_we_do
    @posts = Post.published.recent

    solution_slug = params[:solution_slug]
    @posts = @posts.by_solution_slug(solution_slug) if solution_slug.present?
    @posts
  end
end