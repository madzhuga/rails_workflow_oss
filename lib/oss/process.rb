# frozen_string_literal: true

module OSS
  class Process
    attr_reader :context, :template_identifier

    def initialize(template_identifier, context)
      @template_identifier = template_identifier
      @context = context
    end

    def start

    end
  end
end
