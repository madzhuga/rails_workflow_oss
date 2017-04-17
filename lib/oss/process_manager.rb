# frozen_string_literal: true

module OSS
  # Process Manager is a major endpoint to build new processes.
  # It is initialized with configuration.
  class ProcessManager
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def build(identifier, context)
      builder.build(identifier, context)
    end

    def start(*args)
      process = build(*args)
      process.start
    end

    private

    # TODO: use config to get Builder
    def builder
      Builder.new(self)
    end
  end
end
