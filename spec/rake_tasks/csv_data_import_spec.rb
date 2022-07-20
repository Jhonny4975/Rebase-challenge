# frozen_string_literal: true

require 'spec_helper'
require_relative '../../models/medical_exam'

RSpec.describe 'RakeTasks', type: :rake_task do
  describe '#db:seed:csv_data_import' do
    context 'with success ' do
      it 'fill database' do
        Rake::Task['db:seed:csv_data_import'].execute

        expect(MedicalExam.count).to eq 3900
      end
    end
  end
end
