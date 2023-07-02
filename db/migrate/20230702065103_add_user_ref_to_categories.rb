class AddUserRefToCategories < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :categories, :users, column: :author_id
  end
end
