# frozen_string_literal: true

module OSS
  class Builder
    attr_reader :manager

    def initialize(manager)
      @manager = manager
    end

    def build(identifier, context)
      # TODO: Use loader / cache to get process template
      Process.new(context)
    end
  end
end
