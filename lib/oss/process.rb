# frozen_string_literal: true

require_relative './status_holder.rb'

module OSS
  # Process is a set of operations
  class Process
    include StatusHolder

    attr_reader :context, :template_identifier, :operations
    attr_accessor :errors

    def initialize(template_identifier, context = nil)
      @template_identifier = template_identifier
      @context = context || OSS::Context.new
      self.status = 'not_started'
      @operations = []
    end

    def ready_operations
      @operations.select(&:ready?)
    end

    def completed_operations
      @operations.select(&:completed?)
    end

    def errors
      @errors ||= []
      @errors + operations.flat_map(&:errors)
    end

    def template
      OSS.config.process_template(@template_identifier)
    end
  end
end
