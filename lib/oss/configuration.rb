# frozen_string_literal: true

require 'singleton'

module OSS
  # Configuration is used to contain important settings,
  # perform loading and caching templates etc.
  class Configuration
    attr_writer :builder_class, :loader_class, :processes_path, :runner_class

    # TODO: set up process templates cache, loading etc.
    def process_template(identifier)
      cache.process_template(identifier)
    end

    def builder(*args)
      builder_class.new(*args)
    end

    def runner(process)
      @runner ||= runner_class.new(process)
    end

    def runner_class
      @runner_class ||= Runner
    end

    def builder_class
      @builder_class ||= Builder
    end

    def operation_builder
      operation_builder_class.new
    end

    def operation_builder_class
      @operation_builder_class ||= OperationBuilder
    end

    def load_templates
      loader.load
    end

    def loader
      @loader ||= loader_class.new
    end

    def loader_class
      @loader_class ||= OSS::Loader::Default
    end

    def operation_template_builder
      @operation_template_builder ||= OSS::OperationTemplateBuilder.new
    end

    def processes_path
      @processes_path ||= Dir.pwd + '/processes'
    end

    def cache
      @cache ||= Cache.new
    end

    def persistence_manager
      @persistence_manager ||= PersistenceManager.new
    end
  end
end
