# frozen_string_literal: true

module OSS
  # Builder is used to build new processes.
  class Builder
    attr_reader :manager

    def initialize(manager)
      @manager = manager
    end

    def build(identifier, context)
      template = process_template(identifier)
      Process.new template.identifier, context
    end

    private

    def process_template(identifier)
      OSS.config.process_template(identifier)
    end
  end
end
