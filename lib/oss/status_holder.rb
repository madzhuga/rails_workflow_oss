# frozen_string_literal: true

module OSS
  # Module responsible for processing status changes
  # of operations and processes.
  module StatusHolder
    attr_reader :status
    def status=(new_status)
      @status = new_status
      # binding.pry if new_status == 'in_progress'
      status_changed
    end

    def start
      self.status = 'in_progress'
    end

    def in_progress?
      status == 'in_progress'
    end

    def not_started?
      status == 'not_started'
    end

    def ready?
      status == 'not_started'
    end

    def completed?
      status == 'completed'
    end

    def complete
      return if status == 'failed'
      self.status = 'completed'
    end

    def fail
      self.status = 'failed'
    end

    def failed?
      status == 'failed'
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
