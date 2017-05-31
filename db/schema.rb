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

ActiveRecord::Schema.define(version: 20170531035024) do

  create_table "answers", force: :cascade do |t|
    t.string "answer"
    t.boolean "is_correct"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "course_to_lecture_junctions", force: :cascade do |t|
    t.integer "course_id"
    t.integer "lecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_to_lecture_junctions_on_course_id"
    t.index ["lecture_id"], name: "index_course_to_lecture_junctions_on_lecture_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "year"
    t.string "semester"
    t.string "name"
    t.string "student_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string "title"
    t.date "date_of_use"
    t.integer "question_set_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_set_id"], name: "index_lectures_on_question_set_id"
  end

  create_table "question_set_junctions", force: :cascade do |t|
    t.integer "question_id"
    t.integer "question_set_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_set_junctions_on_question_id"
    t.index ["question_set_id"], name: "index_question_set_junctions_on_question_set_id"
  end

  create_table "question_sets", force: :cascade do |t|
    t.string "name"
    t.boolean "is_readonly"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_to_tag_junctions", force: :cascade do |t|
    t.integer "question_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_to_tag_junctions_on_question_id"
    t.index ["tag_id"], name: "index_question_to_tag_junctions_on_tag_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.string "role"
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_registrations_on_course_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "fname"
    t.string "lname"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
