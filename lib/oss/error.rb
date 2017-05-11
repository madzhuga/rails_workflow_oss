# frozen_string_literal: true

module OSS
  # Context is used to share some data between operations
  # and a process.
  class Error
    attr_accessor :error, :target

    def initialize(error, target:)
      @error = error
      @target = target
      target.errors << self
      target.fail
    end
  end
end
