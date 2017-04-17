# frozen_string_literal: true

RSpec.describe OSS::ProcessManager do
  subject(:process_manager) { described_class.new }

  let(:context) { OSS::Context.new }
  let(:identifier) { 'some_uniq_identifier' }

  before do
    allow(OSS.config.cache)
      .to receive(:process_template)
      .and_return(OSS::ProcessTemplate.new(identifier))
  end

  context '#build' do
    let(:result) { process_manager.build(identifier, context) }

    it 'builds new process' do
      expect(result).to be_a OSS::Process
    end
  end

  context '#start' do
    let(:process) { OSS::Process.new('dumy_identifier', context) }

    before do
      allow(OSS::Process).to receive(:new).and_return(process)
      allow(process).to receive(:start)
    end

    it 'starts new process' do
      process_manager.start(identifier, context)
      expect(process).to have_received(:start)
    end
  end
end
