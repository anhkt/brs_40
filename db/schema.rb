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

ActiveRecord::Schema.define(version: 20161101024642) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "target_id"
    t.integer  "activity_type"
    t.integer  "users_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["users_id"], name: "index_activities_on_users_id", using: :btree
  end

  create_table "book_marks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "reading_status"
    t.boolean  "is_favorite"
    t.integer  "user_id"
    t.integer  "books_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["books_id"], name: "index_book_marks_on_books_id", using: :btree
    t.index ["user_id"], name: "index_book_marks_on_user_id", using: :btree
  end

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "author"
    t.float    "avg_rates",           limit: 24
    t.integer  "number_rate_of_book"
    t.integer  "number_of_page"
    t.integer  "category_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["category_id"], name: "index_books_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",          limit: 65535
    t.integer  "reviews_rates_id"
    t.integer  "users_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["reviews_rates_id"], name: "index_comments_on_reviews_rates_id", using: :btree
    t.index ["users_id"], name: "index_comments_on_users_id", using: :btree
  end

  create_table "like_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "is_like"
    t.integer  "users_id"
    t.integer  "activities_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["activities_id"], name: "index_like_activities_on_activities_id", using: :btree
    t.index ["users_id"], name: "index_like_activities_on_users_id", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  end

  create_table "requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "is_approved"
    t.string   "book_name"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "reviews_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",             limit: 65535
    t.integer  "number_rate_of_user"
    t.integer  "user_id"
    t.integer  "books_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["books_id"], name: "index_reviews_rates_on_books_id", using: :btree
    t.index ["user_id"], name: "index_reviews_rates_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "is_admin"
    t.string   "password_degest"
    t.string   "gravatar"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "activities", "users", column: "users_id"
  add_foreign_key "book_marks", "books", column: "books_id"
  add_foreign_key "book_marks", "users"
  add_foreign_key "books", "categories"
  add_foreign_key "comments", "reviews_rates", column: "reviews_rates_id"
  add_foreign_key "comments", "users", column: "users_id"
  add_foreign_key "like_activities", "activities", column: "activities_id"
  add_foreign_key "like_activities", "users", column: "users_id"
  add_foreign_key "requests", "users"
  add_foreign_key "reviews_rates", "books", column: "books_id"
  add_foreign_key "reviews_rates", "users"
end
