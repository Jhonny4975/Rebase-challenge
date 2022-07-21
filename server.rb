# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'rack/handler/puma'
require './models/medical_exam'
require './services/csv_data_handler'
require './serializers/exam_serializer'

class Server < Sinatra::Base
  configure :production, :development do
    enable :logging
  end

  configure :development do
    disable :raise_errors
    disable :show_exceptions
  end

  set :bind, '0.0.0.0'
  set :port, 3000

  get '/tests' do
    MedicalExam.all.to_json(except: %i[id created_at updated_at])
  end

  post '/import' do
    return 412 unless !params[:csv].nil? && params[:csv][:type] == 'text/csv'

    CsvDataHandler.measure(params[:csv][:tempfile])
    { message: 'Success! Registration will be carried out soon.' }.to_json
  end

  get '/tests/:token' do
    exams = MedicalExam.where(exam_result_token: params[:token])

    return 404 if exams.empty?

    ExamSerializer.details(exams).to_json
  end

  error 412 do
    { error: 'Could not continue, unrecognized file type.' }.to_json
  end

  error 404 do
    { error: 'Could not find exam with given data.' }.to_json
  end

  run! if app_file == $PROGRAM_NAME
end
