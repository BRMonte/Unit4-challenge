require_relative '../../app/discounts/percentual_discount'

describe PercentualDiscount do
  subject(:percent_discount) { described_class.new(percentual_discount: 15, threshold: 1000) }

  describe '.apply' do
    it 'applies the percentual discount on values over the minimum' do
      expect(percent_discount.apply(1500, {})).to eq 225
    end

    it 'applies no discount on values below the minimum' do
      expect(percent_discount.apply(500, {})).to eq 0
    end
  end
end
