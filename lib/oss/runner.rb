# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class Runner
    def start(process)
      process.start
      run(process)
    end

    def run(process)
      until process.ready_operations.empty?
        execute process.ready_operations.first
      end

      process.complete
    end

    def execute(operation)
      operation.start

      # TODO: rescue errors
      operation.execute if operation.respond_to? :execute

      operation.complete
    end
  end
end
