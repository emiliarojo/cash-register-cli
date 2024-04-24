require 'product'

RSpec.describe Product do
  describe '#initialize' do
    it 'initializes Green Tea with correct attributes' do
      product = Product.new('GR1')
      expect(product.code).to eq('GR1')
      expect(product.name).to eq('Green Tea')
      expect(product.price).to eq(3.11)
    end

    it 'initializes Strawberries with correct attributes' do
      product = Product.new('SR1')
      expect(product.code).to eq('SR1')
      expect(product.name).to eq('Strawberries')
      expect(product.price).to eq(5.00)
    end

    it 'initializes Coffee with correct attributes' do
      product = Product.new('CF1')
      expect(product.code).to eq('CF1')
      expect(product.name).to eq('Coffee')
      expect(product.price).to eq(11.23)
    end
  end
end
