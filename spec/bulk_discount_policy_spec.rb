require'bulk_discount_policy'

RSpec.describe BulkDiscountPolicy do
  describe '.apply_discount' do
    it 'applies a bulk discount if the quantity is above the threshold' do
      expect(BulkDiscountPolicy.apply_discount(3, 5.00, 3, 4.50)).to be_within(0.01).of(13.50)
    end

    it 'does not apply a bulk discount if the quantity is below the threshold' do
      expect(BulkDiscountPolicy.apply_discount(2, 5.00, 3, 4.50)).to be_within(0.01).of(10.00)
    end
  end
end
