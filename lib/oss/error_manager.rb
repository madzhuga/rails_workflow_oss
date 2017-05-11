# frozen_string_literal: true

module OSS
  # Error Manager handles all exceptions and manages their processing
  class ErrorManager
    # ErrorManager.build(error: e, operation: operation)
    def build(error:, operation: nil, process: nil)
      Error.new(error, target: operation || process)
    end
  end
end
