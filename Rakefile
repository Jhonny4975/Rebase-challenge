# frozen_string_literal: true

require 'sinatra/activerecord/rake'
require './services/csv_data_handler'

namespace :db do
  namespace :seed do
    desc 'database population'
    task :csv_data_import do
      puts '---- Starting ----'

      MedicalExam.delete_all

      rows = CSV.read('./data.csv', col_sep: ';')

      rows.shift
      CsvDataHandler.import(rows)

      exams_count = MedicalExam.count
      message = '- Successfully imported data'

      message = 'Something went wrong!' if exams_count.zero?

      puts message
      puts " - #{exams_count} exams saved!"

      puts '---- Finishing ----'
    end
  end
end
