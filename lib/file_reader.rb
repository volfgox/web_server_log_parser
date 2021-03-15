# frozen_string_literal: true

# frozen_string_literal

require_relative 'exceptions'

# A wrapper class around file read by line to handle exceptions in
# file and extract info
class FileReader
  def initialize(file_path:)
    raise FileNotFoundError unless File.exist?(file_path)

    @file = open_file(file_path)
  end

  def each_visit
    file.each_line do |line|
      # check if line has expected format
      next unless log_line_validate?(line)

      # Split line in space to get route and ip
      route, ip = line.split

      # Handle empty lines
      next unless route && ip

      yield route, ip
    end
  end

  private

  attr_reader :file

  def open_file(file_path)
    File.open(file_path, 'r')
  rescue StandardError
    # Any other problem with opening the file like permission error catches
    # and unifies into a defined exception here.
    raise UnableToOpenFileError
  end

  def log_line_validate?(str)
    str.match?(%r{/\w+(/\w+)* (\d{1,3}\.){3}\d{1,3}})
  end
end
