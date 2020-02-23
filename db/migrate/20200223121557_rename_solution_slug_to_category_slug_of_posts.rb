class RenameSolutionSlugToCategorySlugOfPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :solution_slug, :category_slug
  end
end
