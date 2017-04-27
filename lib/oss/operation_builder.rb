# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class OperationBuilder
    def build(process, template)
      (template.operation_class || Operation).new(process, template)
    end
  end
end
