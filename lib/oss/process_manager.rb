# frozen_string_literal: true

module OSS
  # Process Manager is a major endpoint to build new processes.
  # It is initialized with configuration.
  class ProcessManager
    def build(identifier, context)
      builder.build(identifier, context)
    end

    def start(*args)
      process = build(*args)
      process.start
    end

    private

    def config
      OSS.config
    end

    def builder
      config.builder(self)
    end
  end
end
