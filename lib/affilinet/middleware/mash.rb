module Affilinet
  module Middleware
    class Mash < Hashie::Mash
      def self.join_arrays(hash)
        hash.each_pair do |key,value|
          hash[key] = value.join(',') if value.is_a? Array
        end
        hash
      end

      def self.camelize_keys(hash)
        hash.keys.each do |key|
          hash[self.camelize(key)] = hash.delete key
        end
        hash
      end

      def self.camelize(term)
        string = term.to_s
        string = string.sub(/^[a-z\d]*/) { $&.capitalize }
        string.gsub!(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }
        string.gsub!('/', '::')
        string
      end

      def self.underscore(camel_cased_word)
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
        Affilinet::Middleware::Mash.underscore key.to_s
      end
    end
  end
end
