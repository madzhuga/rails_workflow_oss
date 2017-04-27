# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class OperationTemplateBuilder
    def build(process, operation_data)
      OperationTemplate.new(process, operation_data)
    end
  end
end
