class AddProjectWhyToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :project_why, :string
  end
end
