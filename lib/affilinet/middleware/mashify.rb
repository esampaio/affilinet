module Affilinet
  module Middleware
    class Mashify < FaradayMiddleware::Mashify
      dependency do
        self.mash_class = Affilinet::Middleware::Mash
      end
    end
  end
end
