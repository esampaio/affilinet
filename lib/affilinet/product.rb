module Affilinet
  class Product < Affilinet::FluentInterfaceBase
    add_attributes [:product_ids, :image_scales, :logo_scales]
    set_endpoint 'GetProducts'
  end
end
