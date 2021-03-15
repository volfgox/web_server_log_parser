# frozen_string_literal: true

require_relative '../../lib/printer'

describe Printer do
  subject { described_class.new }
  let(:visits) do
    [
      ['/contact', 3],
      ['/home', 2],
      ['/about', 1]
    ]
  end

  let(:unique_visits) do
    [
      ['/contact', 2],
      ['/home', 1]
    ]
  end

  describe '#print' do
    it 'prints visit count array' do
      expect($stdout).to receive(:puts).with('Routes visit count')
      expect($stdout).to receive(:puts).with('/contact 3 visits')
      expect($stdout).to receive(:puts).with('/home 2 visits')
      expect($stdout).to receive(:puts).with('/about 1 visit')

      expect($stdout).to receive(:puts).with("\nRoutes unique visit count")
      expect($stdout).to receive(:puts).with('/contact 2 unique views')
      expect($stdout).to receive(:puts).with('/home 1 unique view')

      subject.print(visits, unique_visits)
    end
  end
end
