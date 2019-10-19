class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    
    solution_slug = params[:solution_slug]
    @posts = Post.recent.page(1)
    @posts = @posts.by_solution_slug(solution_slug) if solution_slug.present?

    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end
end

