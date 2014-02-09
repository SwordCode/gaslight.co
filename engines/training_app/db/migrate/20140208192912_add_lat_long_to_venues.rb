class AddLatLongToVenues < ActiveRecord::Migration
  def change
    add_column :training_app_venues, :latitude, :float
    add_column :training_app_venues, :longitude, :string
  end
end
