# frozen_string_literal: true

module OSS
  # Process is a set of operations
  class Process
    attr_reader :context, :template_identifier, :status, :operations

    def initialize(template_identifier, context)
      @template_identifier = template_identifier
      @context = context
      @status = 'NOT_STARTED'
      @operations = []
    end

    def start; end
  end
end
