class CreateExistingSchema < ActiveRecord::Migration
  def change
    create_table "training_app_active_admin_comments", :force => true do |t|
      t.string   "resource_id",   :null => false
      t.string   "resource_type", :null => false
      t.integer  "author_id"
      t.string   "author_type"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "namespace"
    end

    add_index "training_app_active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
    add_index "training_app_active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
    add_index "training_app_active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

    create_table "training_app_admin_users", :force => true do |t|
      t.string   "email",                  :default => "", :null => false
      t.string   "encrypted_password",     :default => "", :null => false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          :default => 0
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "training_app_admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
    add_index "training_app_admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

    create_table "training_app_courses", :force => true do |t|
      t.string   "title"
      t.text     "description_main"
      t.text     "description_close"
      t.date     "start_date"
      t.date     "end_date"
      t.integer  "price"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "venue_id"
    end

    create_table "training_app_courses_trainers", :id => false, :force => true do |t|
      t.integer "course_id"
      t.integer "trainer_id"
    end

    create_table "training_app_discount_requests", :force => true do |t|
      t.integer  "price"
      t.text     "reason"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "training_app_registrations", :force => true do |t|
      t.integer  "amount"
      t.string   "stripe_token"
      t.string   "name"
      t.string   "email"
      t.string   "organization"
      t.string   "phone"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "customer_id"
      t.integer  "workshop_id"
      t.string   "referral_token"
      t.string   "code"
    end

    create_table "training_app_trainers", :force => true do |t|
      t.string   "name"
      t.string   "gravatar_email"
      t.text     "bio"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "training_app_venues", :force => true do |t|
      t.string   "name"
      t.string   "address"
      t.text     "blurb"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "city"
    end

    create_table "training_app_workshops", :force => true do |t|
      t.integer  "venue_id"
      t.integer  "course_id"
      t.integer  "price"
      t.date     "start_date"
      t.date     "end_date"
      t.integer  "capacity"
      t.integer  "early_bird_price"
      t.datetime "early_bird_end_date"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "current"
      t.string   "registration_link"
    end
  end
end
