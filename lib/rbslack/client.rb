require 'faraday'
require 'faraday_middleware'

module Rbslack
  class Client
    BASE_URL = 'https://slack.com'
    attr_reader :api_key, :connection
    def initialize(api_key:)
      @api_key = api_key
      @connection = connection
    end

    def auth_test
      res = connection.post '/api/auth.test', token: api_key, pretty: 1
      puts res.body
    end

    def search(query:)
      res = connection.get '/api/search.messages', token: api_key, query: query
      puts res.body
    end

    private

    def connection
      Faraday.new(url: BASE_URL) do |conn|
        conn.request :url_encoded
        conn.adapter :net_http
        conn.response :json
      end
    end
  end
end
