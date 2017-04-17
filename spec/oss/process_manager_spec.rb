# frozen_string_literal: true

RSpec.describe OSS::ProcessManager do
  subject(:process_manager) { OSS::ProcessManager.new(config) }
  let(:config) { OSS::Config.new }
  let(:context) { OSS::Context.new }
  let(:identifier) { 'some_uniq_identifier' }

  context '#config' do
    specify { expect(subject.config).to eq config }
  end

  context '#build' do
    let(:result) { subject.build(identifier, context) }
    it 'builds new process' do
      expect(result).to be_a OSS::Process
    end
  end

  context '#start' do
    let(:process) { OSS::Process.new('dumy_identifier', context) }

    before do
      allow(process_manager).to receive(:build).and_return(process)
    end

    it 'starts new process' do
      expect(process).to receive(:start)
      subject.start(identifier, context)
    end
  end
end
