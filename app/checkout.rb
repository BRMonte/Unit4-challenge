require_relative 'cart'

class Checkout

  attr_reader :products, :cart, :order

  def initialize(promotional_rules = nil, products: nil, cart_klass: Cart)
    @products = products
    @cart = cart_klass.new(promotional_rules, products: products)
    @order = Hash.new(0)
  end

  def scan(item_code)
    fail "#{item_code} is not a valid item code" unless item_in_products?(item_code)
    @order[item_code] += 1
  end

  def total
    '€%.2f' % order_cost_in_euros
  end

  private

  def order_cost_in_euros
    (cart.total(order) / 100.0).round(2)
  end

  def item_in_products?(item_code)
    products.map{ |product| product.code }.include?(item_code)
  end
end
