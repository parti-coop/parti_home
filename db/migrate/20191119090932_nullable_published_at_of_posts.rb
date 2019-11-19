class NullablePublishedAtOfPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :published_at, :true
  end
end
