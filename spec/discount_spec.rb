require 'discount'
require 'product'

RSpec.describe Discount do
  before(:all) do
    Discount.send(:public, *Discount.private_instance_methods)
  end

  after(:all) do
    Discount.send(:private, *Discount.private_instance_methods)
  end

  let(:discount) { Discount.new }

  describe 'Total Price Calculations' do
    it 'applies correct discounts for GR1, GR1' do
      basket_items = {'GR1' => 2}
      expect(discount.apply_discounts(basket_items)).to be_within(0.01).of(3.11)
    end

    it 'applies correct discounts for SR1, SR1, GR1, SR1' do
      basket_items = {'SR1' => 3, 'GR1' => 1}
      expect(discount.apply_discounts(basket_items)).to be_within(0.01).of(16.61)
    end

    it 'applies correct discounts for GR1, CF1, SR1, CF1, CF1' do
      basket_items = {'GR1' => 1, 'CF1' => 3, 'SR1' => 1}
      expect(discount.apply_discounts(basket_items)).to be_within(0.01).of(30.57)
    end
  end

  describe '#bogo_discount' do
    it 'correctly applies buy-one-get-one-free discount' do
      rule = discount.rules_for('GR1')
      expect(discount.bogo_discount(2, Product::PRICES['GR1'], rule)).to eq(3.11)
    end
  end

  describe '#bulk_discount' do
    it 'correctly applies bulk discount for strawberries' do
      rule = discount.rules_for('SR1')
      expect(discount.bulk_discount(3, Product::PRICES['SR1'], rule)).to eq(13.50)
    end

    it 'correctly applies bulk discount for coffee' do
      rule = discount.rules_for('CF1')
      expect(discount.bulk_discount(3, Product::PRICES['CF1'], rule)).to eq(22.47)
    end
  end

  context 'when there is no applicable discount' do
    it 'calculates the total without discount for one coffee' do
      expect(discount.apply_discounts({'CF1' => 1})).to eq(11.23)
    end

    it 'handles empty baskets' do
      expect(discount.apply_discounts({})).to eq(0)
    end

    it 'handles unknown product codes' do
      expect(discount.apply_discounts({'XYZ' => 2})).to eq(0)
    end
  end

end
