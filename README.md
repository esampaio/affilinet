# Affilinet

Alpha version of a gem to access the [Affilinet](http://affili.net) JSON API.

## Installation

Add this line to your application's Gemfile:

    gem 'affilinet'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install affilinet

## Usage

Examples replicating the instructions on the [API Description](http://developer.affili.net/desktopdefault.aspx/tabid-110/178_read-845)

### Basic setup

````ruby
require 'affilinet'

client = Affilinet::Client.new publisher_id: 580442, password: '1TuKEGkOJJ24dN07ByOy'
````

### Search products

````ruby
result = client.search.query('jeans').all

# > result.products.first.brand
# => "Meat of the Room"
````

### Get Products

````ruby
result = client.products.product_ids([580858761,580858759]).all

# > result.products.first.price_information.display_price
# => "starting from 90.99 GBP "
````
### Get Shop List

````ruby
result = client.shops.all

# > result.shops.first.shop_title
# => "affilinet ShowCase"
````

### Get Category List

````ruby
result = client.categories.shop_id(0).all

# > result.categories.first.title
# => "Clothes & Accessories " 
````

### Get Property List

````ruby
result = client.properties.shop_id(1748).all

# result.property_counts.first.property_name
# => "Colour" 
````

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
