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

    def start
      # TODO: check that status is 'NOT_STARTED' else raise error
      @status = 'IN_PROGRESS'
    end

    def ready_operations
      @operations.select(&:ready?)
    end

    def completed_operations
      @operations.select(&:complete?)
    end

    def complete
      @status = 'COMPLETED'
    end

    def template
      OSS.config.process_template(@template_identifier)
    end
  end
end
