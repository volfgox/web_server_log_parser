# frozen_string_literal: true

require_relative '../../lib/log_file_analyzer'

describe LogFileAnalyzer do
  describe '#execute' do
    let(:reader) { double(:reader) }
    let(:store) { double(:store) }
    let(:printer) { double(:printer) }
    subject do
      described_class.new(reader: reader,
                          store: store,
                          printer: printer)
    end

    before do
      allow(reader).to receive(:each_visit)
        .and_yield('/home', '192.168.1.2')
        .and_yield('/contact', '192.168.1.3')
        .and_yield('/contact', '192.168.1.3')

      allow(store).to receive(:add)

      allow(store).to receive(:visit_count)
        .and_return(
          [
            ['/contact', 3],
            ['/home', 1]
          ]
        )
      allow(store).to receive(:unique_visit_count)
        .and_return(
          [
            ['/contact', 2],
            ['/home', 1]
          ]
        )

      allow(printer).to receive(:print)
    end

    after { subject.execute }

    it 'calls #each_visit of reader and add the pairs in store' do
      expect(reader).to receive(:each_visit)
        .and_yield('/home', '192.168.1.2')
        .and_yield('/contact', '192.168.1.3')
        .and_yield('/contact', '192.168.1.3')

      expect(store).to receive(:add).exactly(3).times
    end

    it 'gets total and unique visits count from store' do
      expect(store).to receive(:visit_count)
      expect(store).to receive(:unique_visit_count)
    end

    it 'calls #print of printer' do
      expect(printer).to receive(:print)
    end
  end
end
