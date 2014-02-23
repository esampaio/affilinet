module Affilinet
  class Category < Affilinet::FluentInterfaceBase
    add_attribute :shop_id
    set_endpoint 'GetCategoryList'
  end
end
