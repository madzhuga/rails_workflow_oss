# frozen_string_literal: true

RSpec.describe OSS::Cache do
  context 'existing process template identifier' do
    let(:identifier) { 'some_identifier' }
    let(:template) { OSS::ProcessTemplate.new(identifier) }
    before do
      allow(subject)
        .to receive(:process_templates)
        .and_return(Hash[identifier, template])
    end

    it 'returns process template by identifier' do
      expect(subject.process_template(identifier)).to eq template
    end
  end

  context 'some not existing process template identifier'

  it 'raises error' do
    expect { subject.process_template('not_existing_identifier') }
      .to raise_error(
        'Process template with identifier not_existing_identifier not found'
      )
  end
end
