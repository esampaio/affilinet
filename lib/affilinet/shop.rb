module Affilinet
  class Shop < Affilinet::FluentInterfaceBase
    add_attributes [:logo_scale, :current_page, :page_size, :updated_after, :query]
    set_endpoint 'GetShopList'
  end
end
