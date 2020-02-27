class AddConfirmMarketingToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :confirm_privacy, :boolean, default: false
    add_column :contacts, :confirm_marketing, :boolean, default: false
    add_column :contacts, :confirm_mailing, :boolean, default: false
    reversible do |dir|
      dir.up do
        transaction do
          execute <<-SQL
            UPDATE contacts
              SET confirm_privacy = true
          SQL
        end
      end
    end
  end
end
