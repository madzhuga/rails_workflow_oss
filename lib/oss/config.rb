# frozen_string_literal: true

require 'singleton'

module OSS
  # Configuration is used to contain important settings,
  # perform loading and caching templates etc.
  class Config
    include Singleton

    attr_writer :builder_class

    # TODO: set up process templates cache, loading etc.
    def process_template(identifier)
      cache.process_template(identifier)
    end

    def builder(*args)
      builder_class.new(*args)
    end

    def builder_class
      @builder_class ||= Builder
    end

    def cache
      @cache ||= Cache.new
    end
  end
end
