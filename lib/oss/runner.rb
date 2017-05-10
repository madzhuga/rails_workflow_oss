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

        # TODO: rescue errors
        operation.execute if operation.respond_to? :execute

        operation.complete
      end

      builder.next_operations(process)
      run_next_operations
    end

    private

    def builder
      OSS.config.builder(self)
    end
  end
end
