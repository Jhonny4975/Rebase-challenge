# frozen_string_literal: true

require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

namespace :db do
  namespace :seed do
    desc 'database population'
    task :csv_data_import do
      require './services/import_from_csv'

      MedicalExam.delete_all

      puts '---- Starting ----'

      message = CsvDataHandler.import('./data.csv')

      exams_count = MedicalExam.count

      message = '- Successfully imported data' if message.nil?

      puts message
      puts " - #{exams_count} exams saved!"

      puts '---- Finishing ----'
    end
  end
end
