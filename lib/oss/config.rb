# frozen_string_literal: true

require 'singleton'

module OSS
  # Configuration is used to contain important settings,
  # perform loading and caching templates etc.
  class Config
    include Singleton

    # TODO: set up process templates cache, loading etc.
    def process_template(identifier)
      ProcessTemplate.new(identifier)
    end
  end
end
