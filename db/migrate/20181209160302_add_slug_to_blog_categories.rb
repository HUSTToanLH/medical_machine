class AddSlugToBlogCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_categories, :slug, :string
    add_index :blog_categories, :slug
  end
end
