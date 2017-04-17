# frozen_string_literal: true

module OSS
  # ProcessTemplate used as a template to build new process
  class ProcessTemplate
    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
    end
  end
end
