# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class OperationTemplateBuilder
    def build(process, operation_data)
      prepare_data(operation_data)
      template = OperationTemplate.new(process, operation_data)
      template
    end

    def prepare_data(operation_data)
      operation_data.keys.each do |key|
        operation_data[key.to_s] = operation_data[key]
        operation_data[key.to_sym] = operation_data[key]
      end
    end
  end
end
