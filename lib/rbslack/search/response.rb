module Rbslack
  module Search
    class Response
      attr_reader :response
      def initialize(response)
        @response = response
      end

      def title
        response['attachments'].first['title']
      end

      def title_link
        response['attachments'].first['title_link']
      end

      def text
        response['attachments'].first['text']
      end
    end
  end
end
