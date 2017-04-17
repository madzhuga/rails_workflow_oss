# frozen_string_literal: true

module OSS
  # OperationTemplate used to build operation
  class OperationTemplate
    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
    end
  end
end
