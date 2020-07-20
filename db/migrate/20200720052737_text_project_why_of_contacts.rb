class TextProjectWhyOfContacts < ActiveRecord::Migration[5.2]
  def change
    change_column :contacts, :project_why, :text
  end
end
