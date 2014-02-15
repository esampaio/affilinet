module Affilinet
  module Middleware
    class Mash < Hashie::Mash
      def underscore(camel_cased_word)
        word = camel_cased_word.to_s.dup
        word.gsub!('::', '/')
        word.gsub!(/(?:([A-Za-z\d])|^)(#{/(?=a)b/})(?=\b|[^a-z])/) { "#{$1}#{$1 && '_'}#{$2.downcase}" }
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        word.tr!("-", "_")
        word.downcase!
        word
      end

      protected
      def convert_key(key)
        underscore key.to_s
      end
    end
  end
end
