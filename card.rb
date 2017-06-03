class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    @rank <= 10 ? @rank : 10
  end

  def name
    face = case rank
    when 1
      "Ace"
    when 11
      "Jack"
    when 12
      "Queen"
    when 13
      "King"
    else
      @rank
    end
    "#{face} of #{@suit}"
  end
end
