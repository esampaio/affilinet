module Affilinet
  module FluentInterface
    module ClassMethods
      def add_attributes(attributes)
        attributes.each do |attr|
          add_attribute attr
        end
      end

      def add_attribute(attr)
        define_method attr do |value|
          spawn.send("#{attr}!", value)
        end

        define_method "#{attr}!" do |value|
          @criteria[attr] = value
          self
        end
      end

      def set_endpoint endpoint
        define_method :endpoint do
          endpoint
        end
      end
    end

    module InstanceMethods
    end
  end

  class FluentInterfaceBase
    extend Affilinet::FluentInterface::ClassMethods
    include Affilinet::FluentInterface::InstanceMethods
    attr_accessor :criteria, :client, :endpoint

    def initialize(client)
      @client = client
      @criteria = {}
    end

    def all
      @client.get endpoint, to_query
    end

    def first
      if (@criteria[:current_page] && @criteria[:page_size])
        new_current_page = (@criteria[:current_page] - 1) * @criteria[:page_size] + 1
        return current_page(new_current_page).page_size(1).all
      end
      all
    end

    def spawn
      clone
    end

    def to_query
      Affilinet::Middleware::Mash.join_arrays Affilinet::Middleware::Mash.camelize_keys @criteria
    end
  end
end
