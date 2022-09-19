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

ActiveRecord::Schema.define(version: 2022_09_19_052153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commits", force: :cascade do |t|
    t.bigint "contributor_id"
    t.text "hash"
    t.date "committed_on"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contributor_id"], name: "index_commits_on_contributor_id"
  end

  create_table "contributors", force: :cascade do |t|
    t.string "name"
    t.string "avatar_url"
    t.date "first_committed_on"
    t.integer "rank"
    t.integer "today_commits"
    t.integer "this_week_commits"
    t.integer "this_month_commits"
    t.integer "this_year_commits"
    t.integer "all_time_commits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_contributors_on_name"
  end

end
