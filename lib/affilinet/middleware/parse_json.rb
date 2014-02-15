module Affilinet
  module Middleware
    class ParseJson < FaradayMiddleware::ParseJson
      define_parser do |body|
        # Check for errors
        if body =~ /ErrorMessages/
          errors = ::JSON.parse body
          raise errors['ErrorMessages'].first['Value']
        end
        # remove BOM (byte order mark) before parsing
        ::JSON.parse body.force_encoding("UTF-8").sub!(/^\xEF\xBB\xBF/, '') unless body.nil? || body.strip.empty?
      end
    end
  end
end
