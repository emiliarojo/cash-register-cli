require 'discount'
require 'bogo_discount_policy'
require 'bulk_discount_policy'

RSpec.describe Discount do
  let(:discount) { Discount.new }

  describe '#apply' do
    it 'applies the correct discount policy for a product code' do
      expect(discount.apply('GR1', 2, 3.11)).to be_within(0.01).of(3.11)
      expect(discount.apply('CF1', 3, 11.23)).to be_within(0.01).of(22.46)
    end

    it 'returns nil if no discount policy exists for a product code' do
      expect(discount.apply('XYZ', 1, 100)).to be_nil
    end
  end
end
