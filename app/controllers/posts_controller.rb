require 'redcarpet/render_strip'

class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])

    category_slug = params[:category_slug]
    @posts = Post.recent.limit(12)
    @posts = @posts.by_category_slug(category_slug) if category_slug.present?

    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    meta_description = Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(@post.body).truncate(100)
    prepare_meta_tags(title: "#{@post.title} - 빠띠", description: meta_description, url: post_url(@post), image: @post.cover.url(:md))
  end
end

