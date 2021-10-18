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

ActiveRecord::Schema.define(version: 2020_11_13_143059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_advertisements", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "advertisements", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_advertisements_on_user_id"
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.string "address"
    t.string "postal_code"
    t.integer "user_id"
    t.integer "city_id"
    t.integer "country_id"
    t.boolean "is_primary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "province_id"
    t.string "instruction"
    t.string "latitude"
    t.string "longitude"
    t.string "street"
    t.string "house_no"
    t.string "suburb"
    t.string "unit_no"
    t.string "landmark"
    t.string "complex"
    t.string "secondary_number"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.float "shipping_price"
    t.integer "category_type", default: 1
  end

  create_table "checkouts", force: :cascade do |t|
    t.integer "billing_address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "user_cart_id"
    t.float "amount"
  end

  create_table "cities", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.integer "province_id"
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "title"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stock_item_id"
    t.integer "inventory", default: 0
  end

  create_table "colors_products", id: false, force: :cascade do |t|
    t.bigint "color_id"
    t.bigint "product_id"
    t.index ["color_id"], name: "index_colors_products_on_color_id"
    t.index ["product_id"], name: "index_colors_products_on_product_id"
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.integer "parent_type"
    t.string "statement"
    t.bigint "user_id"
    t.string "commentor_full_name"
    t.string "commentor_email_address"
    t.string "commentor_phone_number"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "title"
    t.string "address"
    t.string "contact"
    t.string "individual_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "message"
    t.string "name"
    t.string "email"
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "address"
    t.string "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_jobs_on_city_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.boolean "value"
    t.integer "parent_id"
    t.integer "parent_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "peach_payments", force: :cascade do |t|
    t.string "card_number"
    t.string "expiry_date"
    t.string "card_holder"
    t.string "cvv"
    t.float "amount"
    t.string "checkout_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "super_category_id"
    t.integer "category_id"
  end

  create_table "product_colors", force: :cascade do |t|
    t.integer "color_id"
    t.integer "product_id"
    t.string "stock_item_id"
    t.integer "inventory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_types", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inventory"
    t.float "price"
    t.float "length"
    t.float "width"
    t.float "height"
    t.boolean "status"
    t.boolean "visibility"
    t.bigint "product_category_id"
    t.bigint "company_id"
    t.integer "product_type_id"
    t.boolean "clean_and_care"
    t.boolean "warranty"
    t.string "sub_category_material"
    t.string "code"
    t.string "m2"
    t.boolean "is_discounted", default: false
    t.string "stock_item_id"
    t.string "stock_category_id"
    t.string "stock_profile"
    t.boolean "website_item"
    t.datetime "website_listing_date"
    t.datetime "website_expiry_date"
    t.string "online_delivery_charges"
    t.boolean "is_promotional_banner", default: false
    t.integer "assembly_type"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "facebook"
    t.string "instagram"
    t.string "twitter"
    t.integer "gender"
    t.date "dob"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "phone"
    t.string "address"
    t.integer "catalog_download_count", default: 0
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_projects_on_company_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.integer "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "punches", id: :serial, force: :cascade do |t|
    t.integer "punchable_id", null: false
    t.string "punchable_type", limit: 20, null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.datetime "average_time", null: false
    t.integer "hits", default: 1, null: false
    t.index ["average_time"], name: "index_punches_on_average_time"
    t.index ["punchable_type", "punchable_id"], name: "punchable_index"
  end

  create_table "ratings", force: :cascade do |t|
    t.decimal "value"
    t.integer "parent_id"
    t.integer "parent_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "store_name"
    t.string "store_address"
    t.string "store_city"
    t.string "store_country"
    t.string "store_state"
    t.string "store_zip"
    t.string "store_phone"
    t.string "store_email"
    t.string "store_website"
    t.string "store_link"
    t.string "stroe_description"
    t.integer "vender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category_tags"
    t.string "store_fax"
    t.string "operating_hours"
    t.string "long"
    t.string "lat"
  end

  create_table "subscriber_emails", force: :cascade do |t|
    t.string "email"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "super_categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_cart_products", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.integer "quantity"
    t.float "sub_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_cart_id"
    t.integer "color_id"
  end

  create_table "user_carts", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "otp_code"
    t.string "sales_file_path"
  end

  create_table "user_payments", force: :cascade do |t|
    t.integer "user_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.bigint "category_id"
    t.string "username"
    t.string "contact_details"
    t.boolean "active", default: true
    t.bigint "city_id"
    t.boolean "AAA", default: false
    t.index ["category_id"], name: "index_users_on_category_id"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "advertisements", "users"
  add_foreign_key "categories", "categories", column: "parent_id"
  add_foreign_key "cities", "countries"
  add_foreign_key "colors_products", "colors"
  add_foreign_key "colors_products", "products"
  add_foreign_key "comments", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "jobs", "cities"
  add_foreign_key "jobs", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "products", "companies"
  add_foreign_key "products", "product_categories"
  add_foreign_key "profiles", "users"
  add_foreign_key "projects", "companies"
  add_foreign_key "ratings", "users"
  add_foreign_key "users", "categories"
  add_foreign_key "users", "cities"
end
