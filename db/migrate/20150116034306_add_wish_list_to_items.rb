class AddWishListToItems < ActiveRecord::Migration
  def change
    add_column :items, :wishlist_url, :string
    add_column :items, :tell_friend_url, :string
  end
end
