# frozen_string_literal: true

module OSS
  # Error Manager handles all exceptions and manages their processing
  class ErrorManager
    # ErrorManager.build(error: e, operation: operation)
    def build(error:, operation: nil, process: nil)
      Error.new(error, target: operation || process)

      # If operation is failed it also have to
      # put process to failed status
      operation&.process&.fail
    end
  end
end
