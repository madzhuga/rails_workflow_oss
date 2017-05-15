# frozen_string_literal: true

RSpec.describe OSS::Runner do
  before do
    OSS.config.reset

    OSS.setup do |config|
      config.loader_class = OSS::Loader::Json
      config.processes_path = './spec/support/sample_process'
    end

    stub_const('OSS::PersistenceManager', Class.new(OSS::PersistenceManager) do
      attr_reader :cache

      def initialize
        @cache = []
      end

      def save(object)
        cache.push([object.template.identifier, object.status])
      end
    end)
  end

  subject(:runner) { described_class.new(process) }

  let(:identifier) { 'some_dummy_identifier' }
  let(:context) { OSS::Context.new }
  let(:process) { OSS::Builder.new.build(identifier, context) }
  let(:operation) { process.operations.first }
  let(:persistence_manager) { OSS.config.persistence_manager }

  context 'run process' do
    specify do
      expect { runner.start }.to change { process.status }
        .from('not_started').to('completed')
    end

    specify do
      expect { runner.start }
        .to change { process.ready_operations.count }.from(1).to(0)
    end

    specify do
      expect { runner.start }
        .to change { process.completed_operations.count }.from(0).to(2)
    end

    context 'persistence' do
      before do
        runner.start
      end

      it 'saves started process' do
        expect(persistence_manager.cache)
          .to include %w[some_dummy_identifier in_progress]
      end

      it 'saves completed process' do
        expect(persistence_manager.cache)
          .to include %w[some_dummy_identifier completed]
      end

      it 'saves started operation' do
        expect(persistence_manager.cache)
          .to include %w[operation_one in_progress]
      end

      it 'saves completed operation' do
        expect(persistence_manager.cache)
          .to include %w[operation_one completed]
      end
    end
  end

  context 'running operation' do
    context 'calls #execute' do
      before do
        allow(operation)
          .to receive(:respond_to?)
          .with(:execute, any_args)
          .and_return(true)

        allow(operation).to receive(:execute)
        runner.start
      end

      it { expect(operation).to have_received(:execute) }
    end

    context 'raises error' do
      before do
        allow(operation)
          .to receive(:respond_to?)
          .with(:execute, any_args)
          .and_return(true)

        allow(operation).to receive(:execute).and_raise('some error')
        runner.start
      end

      it { expect(process.operations.count).to eq 1 }
      it { expect(process.errors.count).to eq 1 }
      it { expect(process.status).to eq 'failed' }
      it { expect(process).to be_failed }

      it { expect(operation.errors.count).to eq 1 }
      it { expect(operation.status).to eq 'failed' }

      it 'saves failed process' do
        expect(persistence_manager.cache)
          .to include %w[some_dummy_identifier failed]
      end

      it 'saves failed operation' do
        expect(persistence_manager.cache)
          .to include %w[operation_one failed]
      end
    end
  end

  context 'context' do
    let(:context) { OSS::Context.new(process_key: :process_value) }
    let(:first_operation) { process.operations.first }

    it { expect(process.context[:process_key]).to eq :process_value }
    it { expect(first_operation.context[:process_key]).to eq :process_value }

    describe 'operations context' do
      before do
        first_operation.context[:operation_key] = :operation_value
        runner.start
      end

      let(:check_context) { process.operations[1].context }

      it { expect(check_context[:operation_key]).to eq :operation_value }
      it { expect(check_context[:process_key]).to eq :process_value }
    end
  end
end
