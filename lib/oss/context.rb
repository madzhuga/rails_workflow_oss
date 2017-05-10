# frozen_string_literal: true

module OSS
  # Context is used to share some data between operations
  # and a process.
  class Context
    attr_accessor :data

    def initialize(hash = {})
      @data = hash
    end
  end
end
