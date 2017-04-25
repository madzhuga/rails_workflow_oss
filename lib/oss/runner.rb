# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class Runner
    attr_reader :process

    def initialize(process)
      @process = process
    end

    def start
      process.start
      run
    end

    def run
      run_next_operation until process.ready_operations.empty?

      process.complete
    end

    def run_next_operation
      process.ready_operations.map do |operation|
        operation.start

        # TODO: rescue errors
        operation.execute if operation.respond_to? :execute

        operation.complete
      end

      resolver.next_operations_templates.each do |template|
        operation_builder.build(process, template)
      end
    end

    private

    def resolver
      @resolver ||= DependencyResolver.new(process)
    end

    def operation_builder
      OSS.config.operation_builder
    end
  end
end
