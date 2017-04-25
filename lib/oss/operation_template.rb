# frozen_string_literal: true

module OSS
  # OperationTemplate used to build operation
  class OperationTemplate
    attr_reader :identifier, :process, :dependencies

    def initialize(process, options)
      @process = process
      @identifier = options['identifier']
      init_dependencies(options['dependencies'])
    end

    def independent?
      dependencies.empty?
    end

    private

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
