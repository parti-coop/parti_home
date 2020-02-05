class AddTimestampsToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :created_at, :datetime
    add_column :contacts, :updated_at, :datetime
  end
end
