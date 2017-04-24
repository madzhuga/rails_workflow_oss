# frozen_string_literal: true

module OSS
  # Operation
  class Operation
    attr_reader :template, :process, :status

    def initialize(process, operation_template)
      @process = process
      @template = operation_template
      @status = 'NOT_STARTED'

      @process.operations.push(self)
    end

    def start
      @status = 'IN_PROGRESS'
    end

    def ready?
      @status == 'NOT_STARTED'
    end

    def complete?
      @status == 'COMPLETE'
    end

    def complete
      @status = 'COMPLETE'
    end
  end
end
