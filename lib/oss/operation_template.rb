# frozen_string_literal: true

module OSS
  # OperationTemplate used to build operation
  class OperationTemplate
    attr_reader :identifier, :process, :dependencies, :operation_class

    def initialize(process, options)
      @process = process
      @identifier = options['identifier']

      init_operation_class(options['operation_class'])
      init_dependencies(options['dependencies'])
    end

    def independent?
      dependencies.empty?
    end

    private

    def init_operation_class(class_name)
      @operation_class = Object.const_get(class_name) if class_name
    end

    def init_dependencies(dependencies)
      @dependencies = {}
      return if dependencies.nil?

      dependencies.each do |dependency|
        # TODO: raise error if operation is not found
        new_key = process.operations
                         .find { |o| o.identifier == dependency.first.first }
        @dependencies[new_key] = dependency.first.last
      end
    end
  end
end
