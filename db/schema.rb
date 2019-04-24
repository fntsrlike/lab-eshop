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

ActiveRecord::Schema.define(version: 2019_04_24_070252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "o_auth_providers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.boolean "expires"
    t.datetime "expires_at"
    t.index ["user_id"], name: "index_o_auth_providers_on_user_id"
  end

  create_table "ordered_items", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "order_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_ordered_items_on_order_id"
    t.index ["product_id"], name: "index_ordered_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "sum"
    t.datetime "ordered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "shop_id"
    t.string "name", default: "unnamed", null: false
    t.integer "price", default: 0, null: false
    t.text "description"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "o_auth_provider_id", null: false
    t.string "name", null: false
    t.string "oid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.index ["o_auth_provider_id"], name: "index_subscriptions_on_o_auth_provider_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "o_auth_providers", "users"
  add_foreign_key "products", "shops"
  add_foreign_key "shops", "users"
  add_foreign_key "subscriptions", "o_auth_providers"
end
