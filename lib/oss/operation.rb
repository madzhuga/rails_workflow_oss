# frozen_string_literal: true

require_relative './status_holder.rb'

module OSS
  # Operation
  class Operation
    include StatusHolder

    attr_reader :template, :process, :context
    attr_accessor :errors

    # TODO: do we need to delegate operation.identifier
    # to operation.template.identifier?

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

    def errors
      @errors ||= []
    end
  end
end
