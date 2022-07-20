class CreateMedicalExam < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_exams do |t|
      t.string :registration_number, null: false, default: ''
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :birth_date, null: false, default: ''
      t.string :address, null: false, default: ''
      t.string :city, null: false, default: ''
      t.string :state, null: false, default: ''
      t.string :medical_crm, null: false, default: ''
      t.string :crm_doctor_status, null: false, default: ''
      t.string :medical_name, null: false, default: ''
      t.string :medical_email, null: false, default: ''
      t.string :exam_result_token, null: false, default: ''
      t.string :exam_date, null: false, default: ''
      t.string :exam_type, null: false, default: ''
      t.string :exam_type_limits, null: false, default: ''
      t.string :exam_type_result, null: false, default: ''

      t.timestamps
    end
  end
end
