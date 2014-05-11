require "spec_helper_lite"
require "undo"
require "redis"
require_relative '../../../undo/integration/shared_undo_integration_examples.rb'

Undo.configure do |config|
  config.storage = Undo::Storage::Redis.new Redis.new
end

describe Undo do
  include_examples "undo integration"
end
