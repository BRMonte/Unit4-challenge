class Cart

  attr_reader :product_prices, :promotional_rules

  def initialize(promotional_rules, products: nil)
    @promotional_rules = promotional_rules
    @product_prices = products_with_prices(products)
  end

  private

  def products_with_prices(products)
    products.map { |product| [product.code, product.price] }
      .to_h
  end
end
