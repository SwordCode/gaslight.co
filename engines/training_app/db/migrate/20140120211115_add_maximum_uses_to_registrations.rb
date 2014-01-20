class AddMaximumUsesToRegistrations < ActiveRecord::Migration
  def change
    add_column :training_app_discount_codes, :maximum_uses, :integer, default: 0
    add_column :training_app_discount_codes, :expires_on, :date
    add_column :training_app_registrations, :discount_code_id, :integer
  end
end
