# frozen_string_literal: true

require_relative '../../lib/store'

describe Store do
  subject { described_class.new }
  let(:pairs) do
    [
      ['/home', '213.45.200.1'],
      ['/contact', '184.123.665.067'],
      ['/contact', '444.701.448.104'],
      ['/contact', '184.123.665.067']
    ]
  end

  describe '#add' do
    it 'stores route ip pair' do
      route, ip = pairs.first
      expect { subject.add(route, ip) }
        .to change { subject.send(:count, route) }.by(1)
    end
  end

  context 'count visits' do
    before { pairs.each { |pair| subject.add(pair[0], pair[1]) } }

    describe '#visit_count' do
      it 'returns visit count for a route' do
        expect(subject.visit_count).to eq(
          [
            ['/contact', 3],
            ['/home', 1]
          ]
        )
      end
    end

    describe '#unique_visit_count' do
      it 'returns unique visit count for a route' do
        expect(subject.unique_visit_count).to eq(
          [
            ['/contact', 2],
            ['/home', 1]
          ]
        )
      end
    end
  end
end
