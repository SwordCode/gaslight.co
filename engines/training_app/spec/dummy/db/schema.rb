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

ActiveRecord::Schema.define(version: 20131212202421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

end
