class AddAdvertisementIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :advertisement_id, :integer
  end
end
