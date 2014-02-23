module Affilinet
  class Client
    HOST = 'product-api.affili.net/'
    SERVICE = 'productservice.svc/'
    API_TYPE = 'JSON'
    API_VERSION = 'V3/'
    attr_reader :uri, :options, :connection, :publisher_id, :password

    def initialize(options={})
      @options = {ssl: true, image_scales: [], logo_scales: [], shop_ids: [], category_ids: [], facets: []}
      @options.merge! options
      uri = @options[:ssl] ? 'https://' : 'http://'
      uri.concat HOST

      @uri = URI.join uri, API_VERSION, SERVICE, API_TYPE
      @publisher_id = @options[:publisher_id]
      @password = @options[:password]

      @connection = connection
    end

    def connection
      raise ArgumentError, 'publisher_id and password are required to connect' if publisher_id.nil? || password.nil?
      Faraday.new(url: @uri.to_s, params: {publisherId: publisher_id, 'Password' => password}) do |builder|
        builder.use FaradayMiddleware::EncodeJson
        builder.use Affilinet::Middleware::Mashify
        builder.use Affilinet::Middleware::ParseJson
        builder.adapter Faraday.default_adapter
        builder.proxy @options[:proxy]
      end
    end

    def get endpoint, args = {}
      connection.get(endpoint, args).body
    end

    def categories
      Affilinet::Category.new self
    end

    def properties
      Affilinet::Property.new self
    end

    def products
      Affilinet::Product.new self
    end

    def shops
      Affilinet::Shop.new self
    end

    def search
      Affilinet::Search.new self
    end
  end
end
