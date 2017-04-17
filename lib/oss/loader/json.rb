# frozen_string_literal: true

require 'json'

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
    class Json
      def load
        @templates = {}

        Dir[OSS.config.processes_path + '/**/*.json'].each do |file|
          template = build_template(file)
          @templates[template.identifier] = template
        end

        @templates
      end

      private

      def build_template(file)
        data = parse_file(file)
        ProcessTemplate.new(data['identifier'])
      end

      def parse_file(file)
        JSON.parse(File.read(file))
      end
    end
  end
end
