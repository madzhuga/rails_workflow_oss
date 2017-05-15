# frozen_string_literal: true

module OSS
  # Module responsible for processing status changes
  # of operations and processes.
  module StatusHolder
    def status=(new_status)
      @status = new_status
      status_changed
    end

    private

    def status_changed
      persistence_manager.save(self)
    end

    def persistence_manager
      OSS.config.persistence_manager
    end
  end
end
