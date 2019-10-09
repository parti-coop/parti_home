class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :project_subject, null: false
      t.string :solution_slug
      t.text :project_body, null: false
      t.string :attachment
      t.string :attachment_name
      t.string :contact_org
      t.string :contact_manager
      t.string :contact_tel
      t.string :contact_email, null: false
    end
  end
end
