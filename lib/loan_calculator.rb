class LoanCalculator

  COMPOUND_FREQ = 12
  YEARS = 3
  MONTHS = 36
  MAX = 15000
  MIN = 100

  attr_reader :offers

  def initialize(offer:)
    @offer = offer
    @offers = []
  end

  def add_offer(offer)
    @offers << @offer.new(offer)
  end

  def quote(amount)
    @request = amount
    verify_request
    verify_sufficent_funds
    order_offers_by_rate
    request_from_offers
    produce_quote
  end

  private

  def produce_quote
    { requested: @request,
      rate: blended_rate,
      total: total_compounded_repayment.round(2),
      monthly: monthly_repayment.round(2) }
  end

  def order_offers_by_rate
    @offers = offers.sort_by(&:rate)
  end

  def request_from_offers
    amount_needed = @request
    offers.each do |offer|
      return if amount_needed == 0
      offer.taken = amount_needed <= offer.available ? amount_needed : offer.available
      offer.available -= offer.taken
      amount_needed -= offer.taken
    end
  end

  def blended_rate
    @blended_rate ||= offers.map { |offer| offer.taken * offer.rate }.inject(:+) / @request
  end

  def total_compounded_repayment
    @total ||= @request * (1 + blended_rate/COMPOUND_FREQ) ** (COMPOUND_FREQ*YEARS)
  end

  def monthly_repayment
    total_compounded_repayment / MONTHS
  end

  def verify_sufficent_funds
    raise('is not possible to provide a quote') if offers_total < @request
  end

  def offers_total
    offers.map(&:available).inject(:+)
  end

  def verify_request
    raise('invalid amount') if outside_limits?  || not_multiple_100?
  end

  def outside_limits?
    @request > MAX || @request < MIN
  end

  def not_multiple_100?
    @request % 100 != 0
  end

end
