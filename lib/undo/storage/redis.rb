require 'json'

module Undo
  module Storage
    class Redis
      VERSION = "0.0.4"

      def initialize(redis, options = {})
        @redis = redis
        @options = options
      end

      def put(uuid, object)
        redis.set uuid, serialize(object), options
      end

      def fetch(uuid)
        deserialize redis.get uuid, options
      end

      private
      attr_reader :redis, :options

      def serialize(object)
        object.to_json
      end

      def deserialize(data)
        JSON.load data
      end
    end
  end
end
