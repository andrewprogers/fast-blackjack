class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return 0 unless @rank.is_a?(Integer)
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

  def symbol
    case @suit
    when "Spades"
      '♠'
    when "Diamonds"
      '♦'
    when "Hearts"
      '♥'
    when "Clubs"
      '♣'
    else
      '?'
    end
  end

  def ascii_representation
    if (@rank == 10)
      r = "10"
    else
      r = " " + name[0]
    end
    s = symbol
    <<~EOS
      ┌───────────┐
      |#{r}         |
      |           |
      |           |
      |     #{s}     |
      |           |
      |           |
      |        #{r} |
      └───────────┘
      EOS
  end
end
