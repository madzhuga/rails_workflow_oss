# frozen_string_literal: true

RSpec.describe OSS::Loader::Json do
  let(:config) { Class.new(OSS::Config).instance }

  before do
    allow(OSS).to receive(:config).and_return(config)

    OSS.setup do |config|
      config.loader_class = described_class
      config.processes_path = './spec/support/sample_process'
    end
  end

  it 'loads file' do
    expect(OSS.config.cache.process_templates.count).to eq 1
  end

  context 'loaded template' do
    let(:template) { OSS.config.process_template('some_dummy_identifier') }

    it 'has valid class' do
      expect(template).to be_a OSS::ProcessTemplate
    end

    it 'has operation templates' do
      expect(template.operations.map(&:identifier))
        .to match %w[operation_one operation_two]
    end
  end
end
