# frozen_string_literal: true

module OSS
  # Config cache is responsible for caching configuration
  # (process templates, operation templates etc)
  class Cache
    def process_templates
      @process_templates ||= OSS.config.load_templates
    end

    def process_template(identifier)
      process_templates[identifier] ||
        raise("Process template with identifier #{identifier} not found")
    end
  end
end
