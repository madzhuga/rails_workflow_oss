# frozen_string_literal: true

module OSS
  # OperationTemplate used to build operation
  class OperationTemplate
    attr_reader :identifier

    def initialize(process, options)
      @process = process
      @identifier = options['identifier']
      @dependecies = options['dependencies']
    end

    def independent?
      dependencies.nil?
    end

    private

    def dependencies
      @dependecies
    end
  end
end
