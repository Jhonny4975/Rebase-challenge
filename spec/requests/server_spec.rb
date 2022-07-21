# frozen_string_literal: true

require 'spec_helper'
require_relative '../../server'

RSpec.describe Server, type: :request do
  let(:app) { Server.new }

  describe 'GET /tests' do
    context 'when there is no exams' do
      it 'returns an empty json' do
        response = get '/tests'

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'when there is exams' do
      it 'returns a json with all the exam data' do
        rows = CSV.read('spec/support/medical_exam_csv.csv', col_sep: ';')
        rows.shift
        CsvDataHandler.import(rows)

        response = get '/tests'

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body).count).to eq 11
      end
    end
  end

  describe 'POST /import' do
    context 'with valid params' do
      xit 'import the CSV data into the database' do
        # descobrir como testar isso
        response = post '/import', csv: { type: 'text/csv', tempfile: 'spec/support/medical_exam_csv.csv' }

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['message']).to eq 'Success! Registration will be carried out soon.'
        expect(MedicalExam.count).to eq 11
      end
    end

    context 'with invalid params' do
      it 'returns an error when receiving an invalid parameter' do
        response = post '/import', csv: { type: '' }

        expect(response.status).to eq 412
        expect(JSON.parse(response.body)['error']).to eq 'Could not continue, unrecognized file type.'
        expect(MedicalExam.count).to eq 0
      end

      it 'returns an error when receiving an invalid parameter' do
        response = post '/import', 'invalid'

        expect(response.status).to eq 412
        expect(JSON.parse(response.body)['error']).to eq 'Could not continue, unrecognized file type.'
        expect(MedicalExam.count).to eq 0
      end
    end
  end

  describe 'GET /tests/:token' do
    context 'with valid params' do
      it 'returns exam details' do
        fake_result = JSON.parse(File.read('spec/support/exam_serialized_json.json'))
        rows = CSV.read('spec/support/medical_exam_csv.csv', col_sep: ';')
        rows.shift
        CsvDataHandler.import(rows)

        response = get '/tests/IQCZ17'

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)).to eq(fake_result)
      end
    end

    context 'with invalid params' do
      it 'returns not found' do
        response = get '/tests/WHATEVER'

        expect(response.status).to eq 404
        expect(JSON.parse(response.body)['error']).to eq 'Could not find exam with given data.'
      end
    end
  end
end
