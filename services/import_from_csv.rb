# frozen_string_literal: true

require 'sinatra'
require_relative '../models/medical_exam'
require 'csv'

class CsvDataHandler
  def self.import(params_csv)
    columns = MedicalExam.column_names[1..16]

    begin
      rows = CSV.read(params_csv, col_sep: ';')

      rows.shift

      rows.each do |row|
        persist(row, columns)
      end

      nil
    rescue StandardError
      'Could not read the file...'
    end
  end

  def self.persist(row, columns)
    exam = row.each_with_object({}).with_index do |(cell, acc), idx|
      column = columns[idx]
      acc[column] = cell
    end

    MedicalExam.create!(exam)
  end
end
