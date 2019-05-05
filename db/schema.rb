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

ActiveRecord::Schema.define(version: 2019_05_05_223440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "scenes", force: :cascade do |t|
    t.decimal "latitude"
    t.decimal "longitude"
    t.integer "average_int"
    t.integer "variance_int"
    t.integer "votes", default: [], array: true
    t.integer "num_votes", default: 0
    t.text "geograph_uri"
    t.text "src"
    t.jsonb "data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "labels_data"
    t.index ["average_int", "num_votes"], name: "index_scenes_on_average_int_and_num_votes"
    t.index ["latitude", "longitude"], name: "index_scenes_on_latitude_and_longitude"
    t.index ["variance_int"], name: "index_scenes_on_variance_int"
  end

end
