# frozen_string_literal: true

require 'spec_helper'

describe 'parser' do
  context 'with correct input file as argument' do
    let(:command) { system './parser.rb spec/fixtures/webserver.log' }
    let(:info) do
      <<~INFO
        Routes visit count
        /contact 3 visits
        /help_page/1 1 visit

        Routes unique visit count
        /contact 2 unique views
        /help_page/1 1 unique view
      INFO
    end

    it 'prints correct info to stdout' do
      expect { command }.to output(a_string_including(info)).to_stdout_from_any_process
    end
  end

  context 'with not found input file' do
    let(:command) { system './parser.rb fixtures/_.log' }
    let(:not_found_error) { 'ERROR: File not found' }

    it 'prints file not found error message to stderr' do
      expect { command }.to output(a_string_including(not_found_error))
        .to_stderr_from_any_process
    end
  end

  context 'without any argument' do
    let(:command) { system './parser.rb' }
    let(:missed_argument) { 'ERROR: One argument missed.' }

    it 'prints missed argument message to stderr' do
      expect { command }.to output(a_string_including(missed_argument))
        .to_stderr_from_any_process
    end
  end
end
