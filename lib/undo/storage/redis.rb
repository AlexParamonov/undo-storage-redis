require 'json'

module Undo
  module Storage
    class Redis
      def initialize(redis, options = {})
        @redis = redis
      end

      def put(uuid, object)
        redis.set uuid, serialize(object)
      end

      def fetch(uuid)
        deserialize redis.get(uuid)
      end

      private
      attr_reader :redis

      def serialize(object)
        object.to_json
      end

      def deserialize(data)
        JSON.parse data
      end
    end
  end
end
