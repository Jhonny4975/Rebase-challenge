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
        CsvDataHandler.import('spec/support/medical_exam_csv.csv')

        response = get '/tests'

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body).count).to eq 11
      end
    end
  end
end
