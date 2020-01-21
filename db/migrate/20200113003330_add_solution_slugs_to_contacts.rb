class AddSolutionSlugsToContacts < ActiveRecord::Migration[5.2]
  def change
    rename_column :contacts, :solution_slug, :deprecated_solution_slug
    add_column :contacts, :solution_slugs, :string, array: true, default: '[]'

    reversible do |dir|
      dir.up do
        transaction do
          %w(demos org campaign soft etc).each do |slug|
            execute <<-SQL
              UPDATE contacts
                SET solution_slugs = '[\"#{slug}\"]'
              WHERE deprecated_solution_slug = '#{slug}'
            SQL
          end

          execute <<-SQL
            UPDATE contacts
              SET solution_slugs = '[\"etc\"]'
            WHERE deprecated_solution_slug is NULL
          SQL
        end
      end
      dir.down do
        transaction do
          execute <<-SQL
            UPDATE contacts
              SET deprecated_solution_slug = 'etc'
            WHERE solution_slugs is NULL or solution_slugs = "[]"
          SQL
        end
      end
    end
  end
end
