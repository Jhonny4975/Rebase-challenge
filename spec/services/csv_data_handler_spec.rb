# frozen_string_literal: true

require 'spec_helper'
require_relative '../../services/csv_data_handler'

RSpec.describe CsvDataHandler, type: :service do
  describe '#import' do
    context 'with valid csv' do
      it 'import the CSV data into the database' do
        rows = CSV.read('spec/support/medical_exam_csv.csv', col_sep: ';')
        rows.shift
        CsvDataHandler.import(rows)

        expect(MedicalExam.count).to eq 11
      end
    end

    context 'with empy csv' do
      it 'no data is imported' do
        CsvDataHandler.import([])

        expect(MedicalExam.count).to eq 0
      end
    end
  end
end
