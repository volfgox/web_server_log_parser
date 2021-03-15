#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/log_file_analyzer'
require_relative 'lib/file_reader'
require_relative 'lib/store'
require_relative 'lib/printer'

# Here is the place to get input from terminal argument
# The input argument should be checked against possible wrong cases.

if ARGV.empty?
  warn('ERROR: One argument missed.')
  exit 1
end

# Now first argument is the log file.
log_file_path = ARGV[0]

# Try to open the file and create a file handle:w
begin
  reader = FileReader.new(file_path: log_file_path)
rescue FileNotFoundError
  warn('ERROR: File not found')
  exit 1
rescue UnableToOpenFileError
  warn('ERROR: Unable to open file')
  exit 1
end

LogFileAnalyzer.new(reader: reader,
                    store: Store.new,
                    printer: Printer.new).execute
