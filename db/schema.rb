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

ActiveRecord::Schema.define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'artist_requests', force: :cascade do |t|
    t.string 'url',        limit: 255
    t.text 'message'
    t.integer 'user_id'
    t.integer 'status',                 default: 0
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.datetime 'deleted_at'
  end

  add_index 'artist_requests', ['deleted_at'], name: 'index_artist_requests_on_deleted_at', using: :btree

  create_table 'items', force: :cascade do |t|
    t.string 'name',        limit: 255
    t.text 'description'
    t.float 'price'
    t.string 'image_url',   limit: 255
    t.integer 'year'
    t.string 'dimensions',  limit: 255
    t.integer 'category',                default: 0
    t.integer 'status',                  default: 0
    t.integer 'user_id'
    t.integer 'possible_buyer_id'
    t.integer 'buyer_id'
    t.integer 'order_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.datetime 'deleted_at'
  end

  add_index 'items', ['deleted_at'], name: 'index_items_on_deleted_at', using: :btree

  create_table 'orders', force: :cascade do |t|
    t.integer 'user_id'
    t.string 'address',       limit: 255
    t.string 'city',          limit: 255
    t.string 'state',         limit: 255
    t.string 'country',       limit: 255
    t.string 'zip_code',      limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.datetime 'deleted_at'
  end

  add_index 'orders', ['deleted_at'], name: 'index_orders_on_deleted_at', using: :btree

  create_table 'roles', force: :cascade do |t|
    t.string 'name',       limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.datetime 'deleted_at'
  end

  add_index 'roles', ['deleted_at'], name: 'index_roles_on_deleted_at', using: :btree

  create_table 'user_roles', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'role_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.datetime 'deleted_at'
  end

  add_index 'user_roles', ['deleted_at'], name: 'index_users_role_on_deleted_at', using: :btree

  create_table 'users', force: :cascade do |t|
    t.string 'email',         limit: 255
    t.string 'name',          limit: 255
    t.string 'last_name',     limit: 255
    t.string 'username',      limit: 255
    t.string 'password_hash', limit: 255
    t.string 'password_salt', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.datetime 'deleted_at'
  end

  add_index 'users', ['deleted_at'], name: 'index_users_on_deleted_at', using: :btree
end