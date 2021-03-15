# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/file_reader'

describe FileReader do
  describe '#initialize' do
    context 'file not found' do
      subject { described_class.new(file_path: '_.log') }
      it 'panics with file not found error' do
        expect { subject }.to raise_error(FileNotFoundError)
      end
    end
  end

  describe '#each_visit' do
    context 'line with correct format' do
      subject { described_class.new(file_path: 'spec/fixtures/webserver.log') }
      it 'yield route and ip per line' do
        expect { |b| subject.each_visit(&b) }.to yield_successive_args(
          ['/help_page/1', '126.318.035.038'],
          ['/contact', '184.123.665.067'],
          ['/contact', '444.701.448.104'],
          ['/contact', '184.123.665.067']
        )
      end
    end
  end
end
