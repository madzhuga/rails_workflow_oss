# frozen_string_literal: true

require_relative './status_holder.rb'

module OSS
  # Operation
  class Operation
    include StatusHolder

    attr_reader :template, :process, :status, :context
    attr_accessor :errors

    # This method allows to add additional conditions.
    # If returns true - operation will be created, otherwize - will not.
    # @args - array including process, operation template and operation contexts
    def self.satisfy?(_args)
      true
    end

    def initialize(process, operation_template, context: Context.new)
      @process = process
      @template = operation_template
      self.status = 'not_started'
      @context = context

      @process.operations.push(self)
    end

    def start
      self.status = 'in_progress'
    end

    def ready?
      status == 'not_started'
    end

    def completed?
      status == 'completed'
    end

    def errors
      @errors ||= []
    end

    def complete
      self.status = 'completed'
    end

    def fail
      self.status = 'failed'
      process.fail
    end

    def failed?
      status == 'failed'
    end
  end
end
