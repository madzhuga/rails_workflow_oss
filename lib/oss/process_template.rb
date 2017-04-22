# frozen_string_literal: true

module OSS
  # ProcessTemplate used as a template to build new process
  class ProcessTemplate
    attr_reader :identifier
    attr_accessor :operations

    def initialize(identifier)
      @identifier = identifier
      @operations = []
    end

    def independent_operations
      @operations.select(&:independent?)
    end
  end
end
