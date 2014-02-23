module Affilinet
  class Property < Affilinet::FluentInterfaceBase
    add_attribute :shop_id
    set_endpoint 'GetPropertyList'
  end
end
