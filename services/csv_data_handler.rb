# frozen_string_literal: true

require 'sinatra'
require_relative '../models/medical_exam'
require_relative '../workers/import'
require 'csv'

class CsvDataHandler
  def self.measure(csv_tmpfile)
    rows = CSV.read(csv_tmpfile, col_sep: ';')
    rows.shift

    if rows.size > 500
      (rows.size / 500.to_f).ceil.times do
        CsvDataImportWorker.perform_async(rows.shift(500))
      end
    else
      CsvDataImportWorker.perform_async(rows)
    end
  end

  def self.import(rows)
    columns = MedicalExam.column_names[1..16]

    rows.each do |row|
      persist(row, columns)
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
