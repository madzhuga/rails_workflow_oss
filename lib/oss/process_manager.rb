# frozen_string_literal: true

module OSS
  # Process Manager is a major endpoint to build new processes.
  # It is initialized with configuration.
  class ProcessManager
    def build(identifier, context)
      # TODO: context can be both Hash or OSS::Context -
      # build new Context from Hash
      builder.build(identifier, context)
    end

    def start(*args)
      process = build(*args)
      runner.start(process)
    end

    private

    def config
      OSS.config
    end

    def runner
      OSS.config.runner
    end

    def builder
      config.builder(self)
    end
  end
end
