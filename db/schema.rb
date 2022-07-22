# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_21_213243) do
  create_table "measures", force: :cascade do |t|
    t.datetime "timestamp", precision: nil, null: false
    t.string "name", null: false
    t.decimal "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statistics", force: :cascade do |t|
    t.decimal "value", null: false
    t.string "name", null: false
    t.datetime "timestamp", precision: nil, null: false
    t.integer "stat_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
