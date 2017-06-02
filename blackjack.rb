# create a deck of cards
require "pry"

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

class Dealer
  def initialize(num_decks)
    @dealer_cards = []
    @dealer_secret_cards = []
    @deck = []
    ranks = [*(1..13)]
    suits = "Clubs Diamonds Hearts Spades".split(" ")
    num_decks.times do
      ranks.each do |rank|
        suits.each do |suit|
          @deck.push(Card.new(rank, suit))
        end
      end
    end
  end

  def shuffle
    @deck.shuffle!
  end

  def deal
    @deck.pop()
  end

  def add_card(card)
    @dealer_cards << card
  end

  def add_secret_card(card)
    @dealer_secret_cards << card
  end

end

class Player
  def initialize()
    @cards = []
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

  def list_hand
    puts "Cards in the players hand:"
    @cards.each { |card| puts card.name }
  end
end

puts "Welcome to Blackjack."

#game init
puts "Starting a new game"
player = Player.new()
dealer = Dealer.new(1)

puts "The dealer deals you your hand."
player.hit(dealer.deal)
dealer.add_card(dealer.deal)
player.hit(dealer.deal)
dealer.add_secret_card(dealer.deal)
