require 'loan_calculator'
require 'offer'

describe LoanCalculator do

  let(:loan_calculator) { described_class.new( { offer:  Offer } ) }

  offer_1 = { rate: 0.050, available: 500, taken: 0 }
  offer_2 = { rate: 0.020, available: 500, taken: 0 }

  it 'accepts offers' do
    loan_calculator.add_offer(offer_1)
    expect(loan_calculator.offers[0]).to be_a(Offer)
  end

  describe '#quote' do

    context 'when offers exist' do

      it 'it calculates quote when requested' do
        loan_calculator.add_offer(offer_1)
        expect(loan_calculator.quote(500)[:requested]).to eq(500)
      end

      it 'calculates interest rate for one offer' do
        loan_calculator.add_offer(offer_1)
        expect(loan_calculator.quote(500)[:rate]).to eq(0.050)
      end

      it 'calculates blended interest rate for two offers' do
        loan_calculator.add_offer(offer_1)
        loan_calculator.add_offer(offer_2)
        expect(loan_calculator.quote(1000)[:rate]).to eq(0.035)
      end

      it 'gives best rate with two offers' do
        loan_calculator.add_offer(offer_1)
        loan_calculator.add_offer(offer_2)
        expect(loan_calculator.quote(100)[:rate]).to eq(0.020)
      end

      it 'gives best blended rate with two offers' do
        loan_calculator.add_offer(offer_1)
        loan_calculator.add_offer(offer_2)
        expect(loan_calculator.quote(600)[:rate]).to eq(0.025)
      end

      it 'with one offer totals with compound interest' do
        loan_calculator.add_offer(offer_1)
        expect(loan_calculator.quote(500)[:total]).to eq(580.74)
      end

      it 'with two offers totals with compound interest' do
        loan_calculator.add_offer(offer_1)
        loan_calculator.add_offer(offer_2)
        expect(loan_calculator.quote(1000)[:total]).to eq(1110.54)
      end

      it 'calculates monthly repayments' do
        loan_calculator.add_offer(offer_1)
        loan_calculator.add_offer(offer_2)
        expect(loan_calculator.quote(1000)[:monthly]).to eq(30.85)
      end

    end

    context 'when request is higher than available pool' do

      it 'raises error' do
        loan_calculator.add_offer(offer_1)
        expect { loan_calculator.quote(2000) }.to raise_error('is not possible to provide a quote')
      end

    end

    context 'requeste not valid amount' do

      it 'raises error if over 15000' do
        expect { loan_calculator.quote(15100) }.to raise_error('invalid amount')
      end

      it 'raises error if not multiple of 100' do
        expect { loan_calculator.quote(158) }.to raise_error('invalid amount')
      end

      it 'raises error if lower than 100' do
        expect { loan_calculator.quote(0) }.to raise_error('invalid amount')
      end

    end

  end

end
