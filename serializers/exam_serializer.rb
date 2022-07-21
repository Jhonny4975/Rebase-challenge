# frozen_string_literal: true

class ExamSerializer
  def self.details(objects)
    main = objects.first

    {
      result_token: main.exam_result_token,
      result_date: main.exam_date,
      cpf: main.registration_number,
      name: main.name,
      email: main.email,
      birthday: main.birth_date,
      doctor: {
        crm: main.medical_crm,
        crm_state: main.crm_doctor_status,
        name: main.medical_name
      },
      tests: join_tests(objects)
    }
  end

  def self.join_tests(objects)
    objects.map do |object|
      { type: object.exam_type, limits: object.exam_type_limits, result: object.exam_type_result }
    end
  end
end
