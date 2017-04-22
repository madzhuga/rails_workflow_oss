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
      def load(dir = OSS.config.processes_path)
        templates = {}

        Dir[dir + '/**/*.json'].each do |file|
          template = build_template(file)
          templates[template.identifier] = template
        end

        templates
      end

      private

      def build_template(file)
        data = parse_file(file)
        process = ProcessTemplate.new(data['identifier'])

        data['operations'].each do |operation_data|
          build_operation(process, operation_data)
        end

        process
      end

      def build_operation(process, operation_data)
        operation = OperationTemplate.new(process, operation_data)
        process.operations << operation
      end

      def parse_file(file)
        JSON.parse(File.read(file))
      end
    end
  end
end
