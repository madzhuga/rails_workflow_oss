# frozen_string_literal: true

RSpec.describe OSS::Builder do
  let(:identifier) { 'some_dummy_identifier' }
  let(:context) { OSS::Context.new }
  let(:persistence_manager) { OSS.config.persistence_manager }

  context 'build process' do
    before do
      OSS.config.reset

      OSS.setup do |config|
        config.loader_class = OSS::Loader::Json
        config.processes_path = './spec/support/sample_process'
      end

      allow(persistence_manager).to receive(:save).with(any_args)
    end

    subject(:process) { described_class.new.build(identifier, context) }

    specify { expect(process.status).to eq 'not_started' }
    specify { expect(process.operations.count).to eq 1 }
    specify { expect(process.operations.first.status).to eq 'not_started' }

    it 'saves process' do
      expect(persistence_manager).to have_received(:save).with(process)
    end

    context 'hash context' do
      let(:context) { {} }

      specify { expect(process.context).to be_a OSS::Context }
    end
  end
end
