module CheckoutSystem
  class Checkout

    def initialize(pricing_rules = [])
      @pricing_rules = pricing_rules
      @quantities = {}
      @discounts = {}
    end

    def scan(product_code)
      @quantities[product_code] ||= 0
      @quantities[product_code] += 1
    end

    def quantity(product_code)
      @quantities[product_code] || 0
    end

    alias_method :[], :quantity

    def apply_discount(product_code, amount)
      @discounts[product_code] ||= 0
      @discounts[product_code] += amount
    end

    def price_without_discount
      @quantities.inject(0) do |sum, (code, quantity)|
        sum += Product.catalog[code][:price] * quantity
      end
    end

    def discount
      reset_discounts
      apply_pricing_rules
      sum_discounts
    end

    def total
      price_without_discount - discount
    end

    private

      def reset_discounts
        @discounts = {}
      end

      def apply_pricing_rules
        @pricing_rules.each do |pricing_rule|
          pricing_rule.apply_to self
        end
      end

      def sum_discounts
        @discounts.inject(0) do |sum, (code, amount)|
          sum += amount
        end
      end

  end
end
