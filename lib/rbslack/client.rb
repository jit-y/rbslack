require 'faraday'

module Rbslack
  class Client
    BASE_URL = 'https://slack.com'
    attr_reader :token, :connection, :search
    def initialize(token:)
      @connection = connection
      @token = token
    end

    def auth_test
      res = connection.post '/api/auth.test', token: token, pretty: 1
      res.body
    end

    def search
      @search ||= Rbslack::Search::Request.new(connection, token)
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
