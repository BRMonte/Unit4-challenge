require_relative '../../app/checkout'
require_relative '../../app/item'
require_relative '../../app/discounts/percentual_discount'
require_relative '../../app/discounts/item_discount'

describe 'Integration Specs' do
  let(:products) do
    [
      Item.new(code: '001', name: 'Lavender heart', price: 925),
      Item.new(code: '002', name: 'Personalised cufflinks', price: 4500),
      Item.new(code: '003', name: 'Kids T-shirt', price: 1995)
    ]
  end

  let(:ten_percent_discount) { PercentualDiscount.new(percentual_discount: 10, threshold: 6000) }
  let(:lavender_heart_discount) { ItemDiscount.new(item_code: "001", min_items: 2, discount: 75) }
  let(:promotional_rules) { [lavender_heart_discount, ten_percent_discount] }
  subject(:checkout) { Checkout.new(promotional_rules, products: products) }

  it 'applies a 10% discount for orders over €60' do
    checkout.scan '001'
    checkout.scan '002'
    checkout.scan '003'

    expect(checkout.total).to eq '€66.78'
  end

  it 'applies a discount when 2 lavender hearts are ordered' do
    checkout.scan '001'
    checkout.scan '003'
    checkout.scan '001'

    expect(checkout.total).to eq '€36.95'
  end

  it ' applies multiple discounts' do
    checkout.scan '001'
    checkout.scan '002'
    checkout.scan '001'
    checkout.scan '003'

    expect(checkout.total).to eq '€73.76'
  end
end
