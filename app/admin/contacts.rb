ActiveAdmin.register Contact do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :project_subject, :solution_slug, :project_body, :attachment, :contact_org, :contact_manager, :contact_tel, :contact_email
  #
  # or
  #
  # permit_params do
  #   permitted = [:project_subject, :solution_slug, :project_body, :attachment, :contact_org, :contact_manager, :contact_tel, :contact_email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :project_subject, :solution_slug, :project_body, :attachment, :contact_org, :contact_manager, :contact_tel, :contact_email

  index do
    selectable_column
    id_column
    column :project_subject
    column :solution_slug
    column :contact_org
    column :contact_manager
    column :contact_tel
    column :contact_email
    column :updated_at
    actions
  end

  show do
    attributes_table_for resource do
      row :id
      row :project_subject
      row :project_body
      row :solution_slug
      row :attachment do
        span a(resource.attachment_name, href: resource.attachment.url)
      end
      row :contact_org
      row :contact_manager
      row :contact_tel
      row :contact_email
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :project_subject
      f.input :project_body
      f.input :solution_slug, as: :select, collection: Post::SOLUTIONS.map { |solution| [ raw(solution[:title]), solution[:slug] ] }
      f.input :attachment
      li do
        span('# 첨부파일 다운로드')
        a(f.object.attachment_name,  href: f.object.attachment.url)
      end
      f.input :contact_org
      f.input :contact_manager
      f.input :contact_tel
      f.input :contact_email
    end
    f.actions
  end
end
