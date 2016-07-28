class AddDescriptionToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :description, :text # add column to posts table named description of type text
  	add_index :posts, :description # index the description for quick lookup/
  end
end
