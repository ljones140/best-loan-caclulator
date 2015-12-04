class Offer

  attr_reader :rate
  attr_accessor :available, :taken

  def initialize(options)
    @available = options[:available]
    @rate = options[:rate]
    @taken = options[:taken]
  end

end

