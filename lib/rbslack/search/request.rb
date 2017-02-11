module Rbslack
  module Search
    class Request
      attr_reader :connection, :token, :response
      MESSAGE_URL = '/api/search.messages'
      def initialize(connection, token)
        @token = token
        @connection = connection
      end

      def find_by(query)
        res = connection.get(MESSAGE_URL, token: token, query: query, count: 1).body['messages']['matches'].first['previous']
        Rbslack::Search::Response.new(res)
      rescue
        nil
      end
    end
  end
end
