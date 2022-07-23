require_relative '../app/checkout'

describe Checkout do
  let(:cart_klass) { double :cart_klass, new: cart }
  let(:cart) { double :Cart }
  let(:item) { double :Item, code: '001' }
  let(:products) { [item] }
  subject(:checkout) { described_class.new(products: products, cart_klass: cart_klass) }

  describe '.scan' do
    it 'raises an error if is given a code that is not in products' do
      expect{ checkout.scan('002') }.to raise_error '002 is not a valid item code'
    end
  end

  describe '.total' do
    it 'is expected to return the cost of the cart calculated by CostEngine' do
      checkout.scan('001')
      checkout.scan('001')

      allow(cart).to receive(:total)
        .with({'001': 2}).and_return(500)

      expect(checkout.total).to eq '€5.00'
    end
  end
end
