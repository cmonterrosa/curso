# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100701160059) do

  create_table "areas", :force => true do |t|
    t.string  "nombre"
    t.string  "extension_digital",   :limit => 10
    t.string  "extension_analogica", :limit => 10
    t.string  "email",               :limit => 30
    t.string  "tel_directo"
    t.string  "area",                :limit => 30
    t.integer "jerarquia_id"
    t.integer "parent_id"
  end

  create_table "empleados", :force => true do |t|
    t.string  "paterno",   :limit => 40
    t.string  "materno",   :limit => 40
    t.string  "nombre",    :limit => 60
    t.string  "telefono",  :limit => 10
    t.string  "correo",    :limit => 40
    t.integer "puesto_id"
    t.integer "area_id"
  end

  create_table "jerarquias", :force => true do |t|
    t.string "nombre"
  end

  create_table "puestos", :force => true do |t|
    t.string "puesto"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
