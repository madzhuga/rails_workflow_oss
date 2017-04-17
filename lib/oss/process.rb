# frozen_string_literal: true

module OSS
  # Process is a set of operations
  class Process
    attr_reader :context, :template_identifier

    def initialize(template_identifier, context)
      @template_identifier = template_identifier
      @context = context
    end

    def start; end
  end
end
