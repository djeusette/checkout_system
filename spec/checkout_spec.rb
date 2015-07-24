require 'spec_helper'

# To avoid using CheckoutSystem::
include CheckoutSystem

describe "Checkout" do

  before do
    Product.new(:FR1, "Fruit tea", 3.11)
    Product.new(:AP1, "Apple", 5.00)
    Product.new(:CF1, "Coffee", 11.23)

    def buy_one_get_one_free_fruit_tea_rule
      PricingRule.new("Buy-one-get-one-free fruit tea") do |checkout|
        free_fruit_teas = checkout[:FR1] / 2
        checkout.apply_discount(:FR1, free_fruit_teas * Product.catalog[:FR1][:price])
      end
    end

    def bulk_apple_purchases_rule
      PricingRule.new("Apple bulk purchase") do |checkout|
        if checkout[:AP1] >= 3
          checkout.apply_discount(:AP1, checkout[:AP1] * 0.5)
        end
      end
    end
  end

  context "with test data" do

    before do
      @pricing_rules = [buy_one_get_one_free_fruit_tea_rule, bulk_apple_purchases_rule]
    end

    it "does apply buy-one-get-one-free fruit tea rule" do
      co = Checkout.new(@pricing_rules)
      co.scan(:FR1)
      co.scan(:AP1)
      co.scan(:FR1)
      co.scan(:CF1)
      expect(co.total).to eq 19.34
    end

    it "does apply buy-one-get-one-free fruit tea rule" do
      co = Checkout.new(@pricing_rules)
      co.scan(:FR1)
      co.scan(:FR1)
      expect(co.total).to eq 3.11
    end

    it "does apply bulk apple purchase rule" do
      co = Checkout.new(@pricing_rules)
      co.scan(:AP1)
      co.scan(:AP1)
      co.scan(:FR1)
      co.scan(:AP1)
      expect(co.total).to eq 16.61
    end
  end

  context "with other baskets" do
    before do
      @pricing_rules = [buy_one_get_one_free_fruit_tea_rule, bulk_apple_purchases_rule]
    end

    it "does not apply any rule" do
      co = Checkout.new(@pricing_rules)
      co.scan(:AP1)
      co.scan(:AP1)
      co.scan(:FR1)
      co.scan(:CF1)
      expect(co.total).to eq 24.34
    end

    it "does apply both rules" do
      co = Checkout.new(@pricing_rules)
      co.scan(:AP1)
      co.scan(:AP1)
      co.scan(:FR1)
      co.scan(:AP1)
      co.scan(:FR1)
      expect(co.total).to eq 16.61
    end
  end
end
