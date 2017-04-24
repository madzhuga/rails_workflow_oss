# frozen_string_literal: true

RSpec.describe OSS::Runner do
  before do
    OSS.config.reset

    OSS.setup do |config|
      config.loader_class = OSS::Loader::Json
      config.processes_path = './spec/support/sample_process'
    end
  end

  subject(:runner) { described_class.new }

  let(:identifier) { 'some_dummy_identifier' }
  let(:context) { OSS::Context.new }
  let(:process) { OSS::Builder.new.build(identifier, context) }

  context 'run process' do
    specify do
      expect { runner.start(process) }.to change { process.status }
        .from('NOT_STARTED').to('COMPLETED')
        # .from('NOT_STARTED').to('IN_PROGRESS')
    end

    specify do
      expect { runner.start(process) }
        .to change { process.ready_operations.count }.from(1).to(0)
    end

    specify do
      expect { runner.start(process) }
        .to change { process.completed_operations.count }.from(0).to(1)
    end
    # specify { expect(process.status).to eq 'NOT_STARTED' }
    # specify { expect(process.operations.count).to eq 1 }
    # specify { expect(process.operations.first.status).to eq 'NOT_STARTED' }
  end
end
