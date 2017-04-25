# frozen_string_literal: true

module OSS
  # Operation
  class Operation
    attr_reader :template, :process, :status

    def initialize(process, operation_template)
      @process = process
      @template = operation_template
      @status = 'not_started'

      @process.operations.push(self)
    end

    def start
      @status = 'not_started'
    end

    def ready?
      @status == 'not_started'
    end

    def complete?
      @status == 'completed'
    end

    def complete
      @status = 'completed'
    end
  end
end
