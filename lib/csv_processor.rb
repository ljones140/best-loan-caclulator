class CsvProcessor

  require 'csv'

  def initialize(loan_calculator:)
    @loan_calculator = loan_calculator
  end

  def process(csv)
    @offers = CSV.read(csv, converters: :numeric).drop(1).map do |row|
      { rate: row[1], available: row[2], taken: 0 }
    end
  end

  def add_offers_to_calculator
    @offers.each { |offer| @loan_calculator.add_offer(offer) }
  end

end
