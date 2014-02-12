class AddDiscountCodeToRegistrations < ActiveRecord::Migration
  def change
    add_column :training_app_registrations, :discount_code_id, :integer
  end
end

