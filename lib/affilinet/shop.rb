module Affilinet
  class Shop
    attr_accessor :criteria, :client, :endpoint
    @attributes = [:logo_scale, :current_page, :page_size, :updated_after, :query]

    def initialize(client)
      @client = client
      @criteria = {}
      @endpoint = 'GetShopList'
    end

    @attributes.each do |attr|
      define_method attr do |value|
        spawn.send("#{attr}!", value)
      end

      define_method "#{attr}!" do |value|
        @criteria[attr] = value
        self
      end
    end

    def spawn
      clone
    end

    def all
      @client.get @endpoint, to_query
    end

    def first
      new_current_page = (@criteria[:current_page] - 1) * @criteria[:page_size] + 1
      current_page(new_current_page).page_size(1).all
    end

    def to_query
      Affilinet::Middleware::Mash.camelize_keys @criteria
    end
  end
end
