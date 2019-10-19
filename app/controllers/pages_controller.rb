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

  def subscribe_reports
    access_token = ENV['STIBEE_KEY']
    response = HTTParty.post("https://api.stibee.com/v1/lists/7834/subscribers", {
      headers: {
        "AccessToken" => access_token
      },
      body: {
        "eventOccuredBy": "SUBSCRIBER",
        "confirmEmailYN": "Y",
        "subscribers": [
          {
            "email": params[:email],
            "name": params[:name]
          }
        ]
      }.to_json
    })
    if response.code != 200
      flash[:error] = "알 수 없는 오류가 발생했습니다. help@parti.xyz로 구독 신청 메일을 보내 주세요."
      return
    end

    parsed_response = JSON.parse(response.body)
    error = parsed_response["Error"]
    if parsed_response["Ok"] == true
      flash[:success] = "구독 확인 이메일을 발송했습니다. 보내드린 이메일을 확인하면 구독이 완료됩니다."
      return
    end

    if error.present?
      flash[:error] = error["message"]
    else
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