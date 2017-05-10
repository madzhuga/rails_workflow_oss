# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class Builder
    attr_reader :manager

    def initialize(manager = nil)
      @manager = manager
    end

    def build(identifier, context)
      process = build_process(identifier, context)
      next_operations(process)
      process
    end

    def next_operations(process)
      resolver(process).next_operations_templates.each do |template|
        operation_builder.build(process, template)
      end
    end

    private

    def resolver(process)
      @resolver ||= DependencyResolver.new(process)
    end

    def operation_builder
      OSS.config.operation_builder
    end

    def build_process(identifier, context)
      process_context = build_context(context)

      # Technically we can get process template by identifier here
      # and it can be used to build process itself
      # but right now I don't have any specific logic
      # right now.
      Process.new identifier, process_context
    end

    def build_context(context)
      case context
      when Hash
        OSS::Context.new(context)
      else
        context
      end
    end

    def process_template(identifier)
      OSS.config.process_template(identifier)
    end
  end
end
