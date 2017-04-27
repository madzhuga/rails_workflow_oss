# frozen_string_literal: true

RSpec.describe OSS::OperationBuilder do
  let(:new_operation) { described_class.new.build(process, template) }
  let(:process_template) { OSS::ProcessTemplate.new('dummy') }

  let(:process) { OSS::Process.new('dummy_identifier') }

  let(:template) do
    OSS::OperationTemplateBuilder.new.build(process_template, template_data)
  end

  describe '#build' do
    context 'template with no operation class specified' do
      let(:template_data) do
        { 'identifier': 'operation_one' }
      end

      it { expect(new_operation).to be_an_instance_of OSS::Operation }
    end

    context 'template with operation class specified' do
      let(:template_data) do
        {
          'identifier': 'operation_one',
          'operation_class': 'TestOperation'
        }
      end

      before do
        stub_const('TestOperation', Class.new(OSS::Operation))
      end

      it { expect(new_operation).to be_a TestOperation }
    end
  end
end
