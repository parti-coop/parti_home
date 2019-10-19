require 'redcarpet/render_strip'

class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])

    solution_slug = params[:solution_slug]
    @posts = Post.recent.page(1)
    @posts = @posts.by_solution_slug(solution_slug) if solution_slug.present?

    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    meta_description = Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(@post.body).truncate(100)
    prepare_meta_tags(title: "#{@post.title} - Democracy More, Parti", description: meta_description)
  end
end

