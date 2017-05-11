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
      run_next_operations
      process.complete
    end

    def run_next_operations
      return if process.ready_operations.empty?
      process.ready_operations.map do |operation|
        operation.start
        try_execute operation
      end

      return if process.failed?

      builder.next_operations(process)
      run_next_operations
    end

    private

    def try_execute(operation)
      operation.execute if operation.respond_to? :execute
      operation.complete
    rescue StandardError => e
      # TODO: Move error Manager to config
      ErrorManager.new.build(error: e, operation: operation)
    end

    def builder
      OSS.config.builder(self)
    end
  end
end
