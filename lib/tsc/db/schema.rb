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

ActiveRecord::Schema.define(version: 20_211_031_235_751) do
  create_table 'channels', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name', null: false
  end

  create_table 'scores', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'channel_id', null: false
    t.float 'total_score', default: 0.0
    t.float 'current_average', default: 0.0
    t.integer 'messages_sent', default: 0
    t.index ['channel_id'], name: 'index_scores_on_channel_id'
    t.index ['user_id'], name: 'index_scores_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name', null: false
  end

  add_foreign_key 'scores', 'channels'
  add_foreign_key 'scores', 'users'
end
