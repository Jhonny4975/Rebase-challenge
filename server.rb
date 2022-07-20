# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'rack/handler/puma'
require './models/medical_exam'
require './services/import_from_csv'

class Server < Sinatra::Base
  configure :production, :development do
    enable :logging
  end

  set :bind, '0.0.0.0'
  set :port, 3000

  get '/tests' do
    MedicalExam.all.to_json(except: %i[id created_at updated_at])
  end

  run! if app_file == $PROGRAM_NAME
end
