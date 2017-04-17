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

  it 'creates proper template' do
    expect(
      OSS.config.process_template('some_dummy_identifier')
    ).to be_a OSS::ProcessTemplate
  end
end
