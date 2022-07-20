# frozen_string_literal: true

require 'spec_helper'
require_relative '../../services/import_from_csv'
require 'csv'

RSpec.describe CsvDataHandler, type: :service do
  describe '#import' do
    context 'with valid csv' do
      it 'import the CSV data into the database' do
        CsvDataHandler.import('spec/support/medical_exam_csv.csv')

        expect(MedicalExam.count).to eq 11
      end
    end

    context 'with invalid csv' do
      it 'returns an error message' do
        result = CsvDataHandler.import(nil)

        expect(result).to eq 'Could not read the file...'
        expect(MedicalExam.count).to eq 0
      end
    end
  end
end
