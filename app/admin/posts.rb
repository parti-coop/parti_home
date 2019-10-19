ActiveAdmin.register Post do
  config.sort_order = 'published_at_desc'

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :body, :published_at, :solution_slug, :source
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :published_at, :solution_slug, :source]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  scope :all
  scope :published
  scope :unpublished

  index do
    selectable_column
    id_column
    column :title
    column :published_at
    column :solution_slug
    column :source
    column :updated_at
    actions
  end

  show do
    attributes_table_for resource do
      row :id
      row :title
      row :body do
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
        raw(%(<div class="admin-post-show-body site-post-body">#{markdown.render(resource.body)}</div>))
      end
      row :published_at
      row :solution_slug
      row :source
      row :updated_at
      row :cover do
        span img(src: resource.cover.url(:sm))
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :simplemde_editor, input_html: { 'data-options': { spellChecker: false }.to_json }
      f.input :solution_slug, as: :select, collection: Post::SOLUTIONS.map { |solution| [ raw(solution[:title]), solution[:slug] ] }
      f.input :published_at, as: :datepicker
      f.input :cover, hint: image_tag(f.object.cover.url(:sm))
      f.input :cover_cache, as: :hidden
    end
    f.actions
  end

  permit_params :title, :body, :published_at, :solution_slug, :cover

  action_item :publish, only: :show do
    link_to "발행", publish_admin_post_path(post), method: :put unless post.published_at?
  end

  action_item :unpublish, only: :show do
    link_to "발행 취소", unpublish_admin_post_path(post), method: :put if post.published_at?
  end

  member_action :publish, method: :put do
    post = Post.find(params[:id])
    post.update(published_at: Time.zone.now)
    redirect_to admin_post_path(post)
  end

  member_action :unpublish, method: :put do
    post = Post.find(params[:id])
    post.update(published_at: nil)
    redirect_to admin_post_path(post)
  end
end
