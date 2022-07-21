# frozen_string_literal: true

require_relative '../config/sidekiq'
require './services/csv_data_handler'

class CsvDataImportWorker
  include Sidekiq::Worker

  def perform(data)
    CsvDataHandler.import(data)
  end
end
