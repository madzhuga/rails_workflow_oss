# frozen_string_literal: true

RSpec.describe OSS::OperationBuilder do
  let(:new_operation) { described_class.new.build(process, template) }
  let(:process_template) { OSS::ProcessTemplate.new('dummy') }

  let(:process) { OSS::Process.new('dummy_identifier') }

  let(:template) do
    OSS::OperationTemplateBuilder.new.build(process_template, template_data)
  end

  context 'operation persistence' do
    let(:template_data) do
      { 'identifier': 'operation_one' }
    end

    let(:persistence_manager) { OSS.config.persistence_manager }

    before do
      allow(persistence_manager).to receive(:save).with(any_args)
    end

    it 'saves new operation' do
      expect(persistence_manager).to have_received(:save).with(new_operation)
    end
  end

  describe '#build' do
    let(:template_data) do
      {
        'identifier': 'operation_one',
        'operation_class': 'TestOperation'
      }
    end

    context 'template with no operation class specified' do
      let(:template_data) do
        { 'identifier': 'operation_one' }
      end

      it { expect(new_operation).to be_an_instance_of OSS::Operation }
    end

    context 'template with operation class specified' do
      before do
        stub_const('TestOperation', Class.new(OSS::Operation))
      end

      it { expect(new_operation).to be_a TestOperation }
    end

    context 'operation class conditions are not satisfied' do
      before do
        stub_const('TestOperation', Class.new(OSS::Operation) do
          def self.satisfy?(_args)
            false
          end
        end)
      end

      it { expect(new_operation).to be_nil }
    end
  end
end
