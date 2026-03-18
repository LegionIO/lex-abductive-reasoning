# frozen_string_literal: true

RSpec.describe Legion::Extensions::AbductiveReasoning::Helpers::Observation do
  let(:constants) { Legion::Extensions::AbductiveReasoning::Helpers::Constants }

  describe '#initialize' do
    it 'creates an observation with valid surprise_level' do
      obs = described_class.new(content: 'test', domain: :test, surprise_level: :surprising)
      expect(obs.surprise_level).to eq(:surprising)
    end

    it 'accepts all valid SURPRISE_LEVELS' do
      constants::SURPRISE_LEVELS.each do |level|
        obs = described_class.new(content: 'test', domain: :test, surprise_level: level)
        expect(obs.surprise_level).to eq(level)
      end
    end

    it 'raises ArgumentError for invalid surprise_level' do
      expect do
        described_class.new(content: 'test', domain: :test, surprise_level: :bogus)
      end.to raise_error(ArgumentError, /invalid surprise_level/)
    end

    it 'defaults to :notable' do
      obs = described_class.new(content: 'test', domain: :test)
      expect(obs.surprise_level).to eq(:notable)
    end
  end
end
