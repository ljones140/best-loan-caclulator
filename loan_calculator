#!/usr/bin/env ruby
require './lib/loan_calculator.rb'
require './lib/csv_processor.rb'
require './lib/offer.rb'

csv = ARGV[0]
request_amount = ARGV[1].to_i

loan_calculator = LoanCalculator.new( { offer: Offer } )
csv_processor = CsvProcessor.new( { loan_calculator: loan_calculator } )

csv_processor.process(csv)
csv_processor.add_offers_to_calculator

def process_quote(loan_calculator, request_amount)
  begin
  quote = loan_calculator.quote(request_amount)
  rescue
    puts 'it is not possible to provide a quote at this time'
  else
    puts "Requested amount: £#{ quote[:requested] }"
    puts "Rate #{ (quote[:rate] * 100).round(2) }%"
    puts "Monthly repayment: £#{ quote[:monthly] }"
    puts "Total repayment: £#{ quote[:total] }"
  end
end

process_quote(loan_calculator, request_amount)
