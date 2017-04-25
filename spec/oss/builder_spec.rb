# frozen_string_literal: true

RSpec.describe OSS::Builder do
  let(:identifier) { 'some_dummy_identifier' }
  let(:context) { OSS::Context.new }

  context 'build process' do
    before do
      OSS.config.reset

      OSS.setup do |config|
        config.loader_class = OSS::Loader::Json
        config.processes_path = './spec/support/sample_process'
      end
    end

    subject(:process) { described_class.new.build(identifier, context) }

    specify { expect(process.status).to eq 'NOT_STARTED' }
    specify { expect(process.operations.count).to eq 1 }
    specify { expect(process.operations.first.status).to eq 'not_started' }
  end
end
