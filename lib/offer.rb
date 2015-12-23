class Offer

  attr_reader :rate
  attr_accessor :available, :taken

  def initialize(available:, rate:, taken:)
    @available = available
    @rate = rate
    @taken = taken
  end

end

