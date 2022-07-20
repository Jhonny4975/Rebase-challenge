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

ActiveRecord::Schema[7.0].define(version: 2022_07_13_192542) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medical_exams", force: :cascade do |t|
    t.string "registration_number", default: "", null: false
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "birth_date", default: "", null: false
    t.string "address", default: "", null: false
    t.string "city", default: "", null: false
    t.string "state", default: "", null: false
    t.string "medical_crm", default: "", null: false
    t.string "crm_doctor_status", default: "", null: false
    t.string "medical_name", default: "", null: false
    t.string "medical_email", default: "", null: false
    t.string "exam_result_token", default: "", null: false
    t.string "exam_date", default: "", null: false
    t.string "exam_type", default: "", null: false
    t.string "exam_type_limits", default: "", null: false
    t.string "exam_type_result", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
