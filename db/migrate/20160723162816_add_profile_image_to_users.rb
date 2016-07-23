class AddProfileImageToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :profile_image, :string # add column to users table named profile_image of type string
  	add_index :users, :profile_image, unique: true # First, index the profile images for quick lookup. Second, make sure the images(image url) are ALWAYS unique
  end
end
