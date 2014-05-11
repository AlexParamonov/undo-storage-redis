require 'json'
require 'undo/storage/adapter'

module Undo
  module Storage
    class Redis < Adapter
      def initialize(redis, options = {})
        @redis = redis
        super options
      end

      def store(uuid, object, options = {})
        redis.set uuid,
                  pack(object),
                  adapter_options(options)
      end

      def fetch(uuid, options = {})
        data = redis.get(uuid) or raise KeyError, "key #{uuid} not found"
        unpack data
      end

      def delete(uuid, options = {})
        redis.del uuid
      end

      private
      attr_reader :redis
    end
  end
end
