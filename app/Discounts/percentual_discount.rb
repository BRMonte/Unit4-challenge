class PercentualDiscount

  attr_reader :percentual_discount, :threshold

  def initialize(percentual_discount:, threshold:)
    @percentual_discount = percentual_discount
    @threshold = threshold
  end

  def apply(current_total, order)
    should_discount_be_applied?(current_total) ? apply_discount(current_total) : 0
  end

  private

  def should_discount_be_applied?(current_total)
    current_total > threshold
  end

  def apply_discount(current_total)
    current_total * percentual_discount / 100
  end
end
