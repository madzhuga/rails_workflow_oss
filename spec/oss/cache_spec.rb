# frozen_string_literal: true

RSpec.describe OSS::Cache do
  subject(:cache) { OSS.config.cache }

  context 'existing process template identifier' do
    let(:identifier) { 'some_identifier' }
    let(:template) { OSS::ProcessTemplate.new(identifier) }

    before do
      allow(OSS.config.loader)
        .to receive(:load)
        .and_return(Hash[identifier, template])
    end

    it 'returns process template by identifier' do
      expect(cache.process_template(identifier)).to eq template
    end
  end

  context 'some not existing process template identifier' do
    before do
      allow(OSS.config.loader).to receive(:load).and_return({})
    end

    it 'raises error' do
      expect { cache.process_template('not_existing_identifier') }
        .to raise_error(
          'Process template with identifier not_existing_identifier not found'
        )
    end
  end
end
