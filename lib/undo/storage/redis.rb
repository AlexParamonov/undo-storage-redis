require 'undo/serializer/null'

module Undo
  module Storage
    class Redis
      def initialize(redis, options = {})
        @redis = redis
        @serializer = options[:serializer] || Undo::Serializer::Null.new
      end

      def put(uuid, object)
        redis.set uuid, serialize(object)
      end

      def fetch(uuid)
        deserialize redis.get(uuid)
      end

      private
      attr_reader :redis, :serializer

      def serialize(object)
        serializer.to_json object
      end

      def deserialize(data)
        serializer.from_json data
      end
    end
  end
end
