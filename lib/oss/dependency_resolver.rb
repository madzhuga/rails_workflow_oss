# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class DependencyResolver
    attr_reader :process, :dependencies

    def initialize(process)
      @process = process
    end

    def next_operations_templates
      possbile_next_operations.select do |pn|
        pn.dependencies.all? do |(template, statuses)|
          operation = process.operations.find { |o| o.template == template }
          statuses.include?(operation.status)
        end
      end
    end

    private

    def possbile_next_operations
      process.template.operations - existing_operations
    end

    def existing_operations
      process.operations.map(&:template)
    end
  end
end
