module CheckoutSystem
  class Product
    attr_reader :code, :name, :price

    def self.catalog
      @catalog ||= {}
    end

    def initialize(code, name, price)
      @code = code
      @name = name
      @price = price

      add_to_catalog self
    end

    def add_to_catalog(product)
      Product.catalog[product.code] = {name: product.name, price: product.price}
    end

  end
end
