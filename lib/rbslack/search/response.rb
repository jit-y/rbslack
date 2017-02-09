module Rbslack
  module Search
    class Response
      attr_reader :response
      def initialize(response)
        @response = response
      end

      def title
        response['attachments'].each_with_object([]) { |att, acc| acc << att['title'] if att.key?('title') }
      end

      def title_link
        response['attachments'].each_with_object([]) { |att, acc| acc << att['title_link'] if att.key?('title_link') }
      end

      def text
        response['attachments'].each_with_object([]) { |att, acc| acc << att['text'] if att.key?('text') }
      end
    end
  end
end
