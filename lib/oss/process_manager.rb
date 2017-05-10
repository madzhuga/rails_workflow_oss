# frozen_string_literal: true

module OSS
  # Process Manager is a major endpoint to build new processes.
  # It is initialized with configuration.
  class ProcessManager
    attr_reader :process

    def build(identifier, context)
      @process = builder.build(identifier, context)
    end

    def start(*args)
      build(*args)
      runner.start
    end

    private

    def config
      OSS.config
    end

    def runner
      OSS.config.runner(process)
    end

    def builder
      config.builder(self)
    end
  end
end
