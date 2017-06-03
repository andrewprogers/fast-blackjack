require_relative "card"

class Deck
  def initialize
    @deck = []
    ranks = [*(1..13)]
    suits = "Clubs Diamonds Hearts Spades".split(" ")
    ranks.each do |rank|
      suits.each do |suit|
        @deck.push(Card.new(rank, suit))
      end
    end
    @deck.shuffle!
  end

  def deal
    @deck.pop()
  end
end
