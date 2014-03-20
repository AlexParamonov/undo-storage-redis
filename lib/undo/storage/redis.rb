require 'json'

module Undo
  module Storage
    class Redis

      def initialize(redis, options = {})
        @redis = redis
        @default_options = options
      end

      def store(uuid, object, options = {})
        redis.set uuid, serialize(object), default_options.merge(options)
      end

      def fetch(uuid, options = {})
        deserialize redis.get uuid
      end

      def delete(uuid, options = {})
        deserialize redis.del uuid
      end

      private
      attr_reader :redis, :default_options

      def serialize(object)
        object.to_json
      end

      def deserialize(data)
        JSON.load data
      end
    end
  end
end
