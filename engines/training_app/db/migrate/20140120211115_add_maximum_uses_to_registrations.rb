class AddMaximumUsesToRegistrations < ActiveRecord::Migration
  def change
    add_column :training_app_discount_codes, :maximum_uses, :integer, default: 0
    add_column :training_app_discount_codes, :expires_on, :date
  end
end
