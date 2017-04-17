# frozen_string_literal: true

module OSS
  # Config cache is responsible for caching configuration
  # (process templates, operation templates etc)
  class Cache
    def process_templates
      # TODO: load processes
      @process_templates ||= begin
        OSS.config.loader.load
      end
    end

    def process_template(identifier)
      process_templates[identifier] ||
        raise("Process template with identifier #{identifier} not found")
    end
  end
end
