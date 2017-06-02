# create a deck of cards
require "pry"

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    @rank
  end

end


class Deck
  def initialize(num_decks)
    @num_decks = num_decks
    @stack = []
    ranks = [*(1..13)]
    suits = "Clubs Diamonds Hearts Spades".split(" ")
    num_decks.times do
      ranks.each do |rank|
        suits.each do |suit|
          @stack.push(Card.new(rank, suit))
        end
      end
    end
  end

  def shuffle
    @stack.shuffle!
  end

  def deal
    @stack.pop()
  end
end

class Player
  def initialize(initial_cards)
    @cards = initial_cards
  end

  def total
    sum = 0
    cards.each do |card|
      sum += card.rank
    end
    sum
  end

  def hit(card)
    @cards << card
  end

  def bust?
    self.total > 21
  end
end

puts "Welcome to Blackjack."

#game init
puts "Starting a new game"
deck = Deck.new(1)
