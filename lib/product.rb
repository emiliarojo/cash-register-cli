# Manages individual product properties.
class Product
  attr_reader :code, :name, :price

  PRODUCTS = {
    'GR1' => { name: 'Green Tea', price: 3.11 },
    'SR1' => { name: 'Strawberries', price: 5.00 },
    'CF1' => { name: 'Coffee', price: 11.23 }
  }.freeze

  def initialize(code)
    product = PRODUCTS[code]
    @code = code
    @name = product[:name]
    @price = product[:price]
  end
end
