Checkout System
A checkout system that calculates the cost of a basket and applies any special discounts or pricing rules which are required for that order.

Usage Instructions
The system can be run from a REPL such as irb or pry. To open irb enter $ irb while in the project root directory.

$ irb

# I- import checkout and item files from lib,

require_relative 'app/checkout'
require_relative 'app/item'

# II- require the discounts you plan to use,

require_relative 'app/discounts/item_discount'
require_relative 'app/discounts/percentual_discount'

# III- Create Item objects,
item_001 = Item.new(code: '001', name: 'Lavender heart', price: 925)
item_002 = Item.new(code: '002', name: 'Personalised cufflinks', price: 4500)
item_003 = Item.new(code: '003', name: 'Kids T-shirt', price: 1995)

# IV- Store the above items in an array to be used by the system
products = [item_001, item_002, item_003]

# V- Create the promotional rules you need to apply,
# Two constructors are provided: PercentualDiscount and ItemDiscount

# Example rule: apply a 10% discount to orders over €60,00
ten_percent_discount = PercentualDiscount.new(percentual_discount: 10, threshold: 6000)

# Example rule: apply a €0.75 discount/item if you order at least 2 "001" items
lavender_heart_discount = ItemDiscount.new(item_code: "001", min_items: 2, discount: 75)

# VI- Store the promotion rules in an array in the order you want them to be applied
pricing_rules = [lavender_heart_discount, ten_percent_discount]

# VII- initialize the Checkout with the pricing_rules and your products
checkout = Checkout.new(pricing_rules, products: products)

# The checkout has 2 methods,
# #scan => takes the item's key code as a string and adds it to your cart
# #total => returns the cart's total cost as a string in euros

# For example here's a basket which takes advantage of both rules we built
checkout.scan '001'
checkout.scan '002'
checkout.scan '001'
checkout.scan '003'

price = checkout.total
price # => '€73.76'

Running Tests
To run the test suite, simply run rspec from the root directory.

$ rspec
