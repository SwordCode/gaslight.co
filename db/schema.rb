# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140212033154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "blog_app_alias_tags", id: false, force: true do |t|
    t.integer "tag_id"
    t.integer "alias_id"
  end

  add_index "blog_app_alias_tags", ["alias_id"], name: "index_blog_app_alias_tags_on_alias_id", using: :btree
  add_index "blog_app_alias_tags", ["tag_id"], name: "index_blog_app_alias_tags_on_tag_id", using: :btree

  create_table "blog_app_old_slugs", force: true do |t|
    t.string   "old_slug"
    t.string   "new_slug"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blog_app_old_slugs", ["old_slug"], name: "index_blog_app_old_slugs_on_old_slug", using: :btree

  create_table "blog_app_posts", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "author"
    t.string   "old_tags"
    t.text     "body"
    t.text     "html"
    t.datetime "published_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "audio_url"
    t.text     "description"
    t.integer  "external_comments_count", default: 0
  end

  add_index "blog_app_posts", ["slug"], name: "index_blog_app_posts_on_slug", using: :btree

  create_table "blog_app_taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "blog_app_taggings", ["tag_id"], name: "index_blog_app_taggings_on_tag_id", using: :btree
  add_index "blog_app_taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_type_and_context", using: :btree

  create_table "blog_app_tags", force: true do |t|
    t.string "name"
  end

  create_table "training_app_chapters", force: true do |t|
    t.string  "title"
    t.integer "sort_order"
    t.text    "description"
    t.string  "video_url"
    t.string  "code_url"
    t.string  "poster_url"
    t.integer "section_id"
    t.boolean "demo"
    t.integer "duration"
  end

  create_table "training_app_courses", force: true do |t|
    t.string   "title"
    t.text     "description_main"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
    t.string   "image_url"
    t.text     "synopsis"
    t.integer  "capacity"
    t.integer  "early_bird_price"
    t.datetime "early_bird_end_date"
    t.string   "registration_link"
    t.integer  "parent_course_id"
    t.boolean  "online",              default: false
    t.string   "color_primary"
    t.string   "color_secondary"
    t.boolean  "active",              default: true
    t.text     "introduction"
  end

  create_table "training_app_courses_instructors", id: false, force: true do |t|
    t.integer "course_id"
    t.integer "instructor_id"
  end

  create_table "training_app_discount_codes", force: true do |t|
    t.string   "code"
    t.integer  "price"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_app_discount_requests", force: true do |t|
    t.integer  "price"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_app_instructors", force: true do |t|
    t.string   "name"
    t.string   "image_url"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_app_registrations", force: true do |t|
    t.integer  "amount"
    t.string   "stripe_token"
    t.string   "name"
    t.string   "email"
    t.string   "organization"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_id"
    t.integer  "course_id"
    t.string   "referral_token"
    t.string   "code"
    t.string   "last4"
    t.string   "card_type"
    t.date     "expires_on"
    t.integer  "discount_code_id"
  end

  create_table "training_app_sections", force: true do |t|
    t.string  "title"
    t.integer "course_id"
    t.integer "sort_order"
  end

  create_table "training_app_venues", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "blurb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.float    "latitude"
    t.string   "longitude"
  end

end
