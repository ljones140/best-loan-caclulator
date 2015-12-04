require 'offer'

describe Offer do

  let(:offer) { described_class.new( { available: 100, rate: 0.050, taken: 0 } ) }

  it 'has available amount' do
    expect(offer.available).to eq(100)
  end

  it 'has rate' do
    expect(offer.rate).to eq(0.050)
  end

  it 'has taken amount' do
    expect(offer.taken).to eq(0)
  end

  it 'allows available to be set' do
    offer.available = 50
    expect(offer.available).to eq(50)
  end

  it 'allows taken to be set' do
    offer.taken = 100
    expect(offer.taken).to eq(100)
  end

end
