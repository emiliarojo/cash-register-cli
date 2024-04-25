require 'discount'
require 'product'

RSpec.describe Discount do
  let(:discount) { Discount.new }
  let(:cart_items) { {'GR1' => 1, 'SR1' => 3, 'CF1' => 4} }

  it 'applies correct discounts for various products' do
    expect(discount.apply_discounts(cart_items)).to eq(38.62)
  end

  describe '#bogo_discount' do
    it 'correctly applies buy-one-get-one-free discount' do
      expect(discount.bogo_discount(2, 3.11)).to eq(3.11)
    end
  end

  describe '#bulk_discount' do
    it 'correctly applies bulk discount' do
      expect(discount.bulk_discount(3, 5.00)).to eq(13.50)
    end
  end

  context 'when there is no applicable discount' do
    it 'calculates the total without discount' do
      expect(discount.apply_discounts({'CF1' => 1})).to eq(11.23)
    end
  end

end
