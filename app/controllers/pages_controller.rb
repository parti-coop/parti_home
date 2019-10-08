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

  private

  def fetch_what_we_do
    @posts = Post.published.recent

    solution_slug = params[:solution_slug]
    @posts = @posts.by_solution_slug(solution_slug) if solution_slug.present?
    @posts
  end
end