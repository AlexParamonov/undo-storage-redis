module Undo
  module Storage
    class Redis
      module Gemspec
        VERSION = "0.0.1"
        RUNNING_ON_CI = !!ENV['CI']
      end
    end
  end
end
