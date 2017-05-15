# frozen_string_literal: true

require_relative './status_holder.rb'

module OSS
  # Process is a set of operations
  class Process
    include StatusHolder

    attr_reader :context, :template_identifier, :status, :operations
    attr_accessor :errors

    def initialize(template_identifier, context = nil)
      @template_identifier = template_identifier
      @context = context || OSS::Context.new
      self.status = 'not_started'
      @operations = []
    end

    def start
      self.status = 'in_progress'
    end

    def in_progress?
      status == 'in_progress'
    end

    def ready_operations
      @operations.select(&:ready?)
    end

    def not_started?
      status == 'not_started'
    end

    def completed_operations
      @operations.select(&:completed?)
    end

    def complete
      return if status == 'failed'
      self.status = 'completed'
    end

    def completed?
      status == 'completed'
    end

    def fail
      self.status = 'failed'
    end

    def failed?
      status == 'failed'
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
