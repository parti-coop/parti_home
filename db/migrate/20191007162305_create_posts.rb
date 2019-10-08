class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :published_at, null: false
      t.string :solution_slug
      t.string :source
      t.timestamps null: false
    end
  end
end
