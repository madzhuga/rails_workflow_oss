# frozen_string_literal: true

RSpec.describe OSS::OperationTemplateBuilder do
  let(:template_data) do
    {
      'identifier': 'operation_one',
      'operation_class': 'TestOperation'
    }
  end
  let(:process) { OSS::Process.new('dummy_identifier') }
  let(:template) { subject.build(process, template_data) }

  before do
    stub_const('TestOperation', Class.new(OSS::Operation))
  end

  it { expect(template.identifier).to eq 'operation_one' }
  it { expect(template.operation_class).to eql TestOperation }
end
