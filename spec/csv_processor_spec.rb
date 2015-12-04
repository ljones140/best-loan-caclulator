require 'csv_processor'

describe CsvProcessor do

  csv = 'market.csv'

  let(:loan_calculator) { double(:loan_calculator, add_offer: true) }

  let(:csv_processor) { described_class.new( { loan_calculator: loan_calculator } ) }


  it 'converts CSV to array' do
    expect(csv_processor.process(csv)).to eq([{ rate: 0.075, available: 640, taken: 0 },
                                              { rate: 0.069, available: 480, taken: 0 },
                                              { rate: 0.071, available: 520, taken: 0 },
                                              { rate: 0.104, available: 170, taken: 0 },
                                              { rate: 0.081, available: 320, taken: 0 },
                                              { rate: 0.074, available: 140, taken: 0 },
                                              { rate: 0.071, available: 60, taken: 0 } ])
  end

  it 'adds hash to loan_calculator' do
    csv_processor.process(csv)
    expect(loan_calculator).to receive(:add_offer).with(hash_including(rate: 0.069, available: 480, taken: 0))
    csv_processor.add_offers_to_calculator
  end

  it 'adds all offers to loan_calculator' do
    csv_processor.process(csv)
    expect(loan_calculator).to receive(:add_offer).exactly(7).times
    csv_processor.add_offers_to_calculator
  end

end
