module Affilinet
  class Search < Affilinet::FluentInterfaceBase
    add_attributes [:shop_ids, :shop_id_mode, :query, :category_ids, :f_q,
                    :use_affilinet_categories, :exclude_sub_categories,
                    :with_image_only, :image_scales, :logo_scales, :sort_by,
                    :current_page, :page_size, :minimum_price, :maximum_price, 
                    :sort_order, :facet_fields, :facet_value_limit]
    set_endpoint 'SearchProducts'

    def to_query
      query = @criteria.delete :query
      @criteria = Affilinet::Middleware::Mash.join_arrays Affilinet::Middleware::Mash.camelize_keys @criteria
      @criteria.merge({'query' => query})
    end
  end
end
