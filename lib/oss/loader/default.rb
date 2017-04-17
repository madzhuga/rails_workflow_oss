# frozen_string_literal: true

module OSS
  module Loader
    # Loader is responsible for loading configuration.
    # It can load config from DB, JSON, Yaml or any other
    # way you want.
    # Just update Config to include key
    # OSS.setup do |config|
    #   ...
    #   config.loader = YourLoader
    #   ...
    # end
    class Default
      def load
        # raise 'Please specify Loader in OSS Configuration'
      end
    end
  end
end
