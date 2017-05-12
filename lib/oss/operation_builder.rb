# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class OperationBuilder
    attr_reader :process, :template, :context

    def build(process, template)
      @process = process
      @template = template

      args = [process, template, context: context]

      operation_class.new(*args) if operation_class.satisfy?(args)
    end

    private

    def context
      @build_context ||= build_context
    end

    def operation_class
      # TODO: Move Operation to OSS.config.default_operation_class
      (template.operation_class || Operation)
    end

    def build_context
      OSS::Context.new(matched_dependencies
        .map(&:context).inject({}) { |res, context| res.merge(context.data) }
        .merge(process.context&.data))
    end

    def matched_dependencies
      process.operations.select do |operation|
        template.dependencies[operation.template].include? operation.status
      end
    end
  end
end
