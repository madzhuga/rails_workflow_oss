# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class OperationBuilder
    def build(process, template)
      Operation.new(process, template)
    end

    private

    # def possible_next_operations(process)
    #   (process.template.operations - process.operations.map(&:template))
    # end
  end
end
