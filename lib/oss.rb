# frozen_string_literal: true

# OSS is an Operations Support System engine. It allows to
# build and run processes.
module OSS
  def self.config
    Config.instance
  end

  # TODO: Add documentation, example, test
  def self.setup
    yield config
  end
end
