# frozen_string_literal: true

require 'singleton'

module OSS
  # Config is a singleton decorator for a configuration
  class Config
    include Singleton

    def reset
      @config = Configuration.new
    end

    private

    def initialize
      reset
    end

    attr_reader :config

    def method_missing(name, *args, &block)
      config.respond_to?(name) ? config.send(name, *args, &block) : super
    end

    def respond_to_missing?(method_name, include_private = false)
      config.respond_to?(method_name) || super
    end
  end
end
