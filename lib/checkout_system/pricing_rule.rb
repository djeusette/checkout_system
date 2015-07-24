module CheckoutSystem
  class PricingRule
    attr_reader :name

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def apply_to(checkout)
      @block.call(checkout)
    end
  end
end
