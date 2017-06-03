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

class Dealer
  def initialize()
    @dealer_cards = []
    @dealer_secret_card = nil
  end

  def add_card(card)
    @dealer_cards << card
  end

  def add_secret_card(card)
    @dealer_secret_card = card
  end

  def list_hand
    puts "\nCards in the dealers hand:"
    @dealer_cards.each { |card| puts "  " + card.name }
    puts "  ...and one face-down card" unless @dealer_secret_card.nil?
  end

  def reveal_card
    card = @dealer_secret_card
    @dealer_secret_card = nil
    puts "The dealer turns up the #{card.name}"
    @dealer_cards << card
  end

  def total
    sum = 0
    @dealer_cards.each do |card|
      sum += card.value
    end
    sum
  end

  def bust?
    self.total > 21
  end

end

class Player
  attr_accessor :stay
  def initialize()
    @cards = []
    @stay = false
  end

  def total
    sum = 0
    @cards.each do |card|
      sum += card.value
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
    puts "\nCards in the players hand:"
    @cards.each { |card| puts "  " + card.name }
  end
end

def print_title
  puts "Welcome to Blackjack."
  puts "----------------------------"
end



print_title

player = Player.new()
dealer = Dealer.new()
deck = Deck.new()


puts "The dealer deals you your hand."
player.hit(deck.deal)
dealer.add_card(deck.deal)
player.hit(deck.deal)
dealer.add_secret_card(deck.deal)

while ( !player.stay ) do
  player.list_hand
  dealer.list_hand

  print "\nHit - h, Stay - s (or any other key): "
  char = gets.chomp
  if char == 'h'
    card = deck.deal
    puts "The dealer deals you a #{card.name}"
    player.hit(card)
    break if player.bust?
  else
    puts "You stay"
    player.stay = true
  end
end

if (player.bust?)
  puts "You've gone bust!!! You lose"
  return
else
  puts "It is the dealers turn"
end

dealer.reveal_card

while dealer.total <= 16 do
  dealer.add_card(deck.deal)
end

player.list_hand
dealer.list_hand

if (dealer.bust? || player.total > dealer.total)
  puts "Player wins"
elsif (player.total == dealer.total)
  puts "Tie game"
else
  puts "Dealer wins"
end
