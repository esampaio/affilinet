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

    def categories id=0
      get 'GetCategoryList', 'ShopId' => id
    end

    def properties id
      get 'GetPropertyList', 'ShopId' => id
    end

    def shops args = {}
      options = @options.merge args
      get 'GetShopList',
        'LogoScale'    => options[:logo_scale],
        'CurrentPage'  => options[:page],
        'PageSize'     => options[:page_size],
        'Query'        => options[:query],
        'UpdatedAfter' => options[:updated_after]
    end

    def products ids = [], args = {}
      options = @options.merge args
      get 'GetProducts',
        'ProductIds'  => ids.take(50).join(','),
        'ImageScales' => options[:image_scales].join(','),
        'LogoScales'  => options[:logo_scales].join(',')
    end

    def search args = {}
      options = @options.merge args
      get 'SearchProducts',
        'ShopIds'                => options[:shop_ids].join(','),
        'ShopIdMode'             => options[:shop_id_exclude] ? 'Exclude' : 'Include',
        'Query'                  => options[:query],
        'CategoryIds'            => options[:category_ids].join(','),
        'UseAffilinetCategories' => options[:affilinet_categories],
        'ExcludeSubCategories'   => options[:categories_exclude],
        'WithImageOnly'          => options[:image_only],
        'ImageScales'            => options[:image_scales].join(','),
        'LogoScales'             => options[:logo_scales].join(','),
        'CurrentPage'            => options[:page],
        'PageSize'               => options[:page_size],
        'MinimumPrice'           => options[:price_min],
        'MaximumPrice'           => options[:price_max],
        'SortBy'                 => options[:sort_by],
        'SortOrder'              => options[:sort_asc] ? 'ascending' : 'descending',
        'FacetFields'            => options[:facets].take(4).join(','),
        'FacetValueLimit'        => options[:facet_limit],
        'FQ'                     => options[:filter_query]
    end
  end
end
