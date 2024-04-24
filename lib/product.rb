class Product
  PRICES = {
    'GR1' => 3.11,
    'SR1' => 5.00,
    'CF1' => 11.23
  }.freeze

  NAMES = {
    'GR1' => 'Green Tea',
    'SR1' => 'Strawberries',
    'CF1' => 'Coffee'
  }.freeze

  attr_reader :code, :name, :price

  def initialize(code)
    @code = code
    @name = NAMES[code]
    @price = PRICES[code]
  end
end
