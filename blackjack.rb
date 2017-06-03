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

class GenericHand
  attr_accessor :stay
  attr_reader :bust

  def initialize()
    @cards = []
    @stay = false
    @bust = false
    @name = "generic player"
  end

  def total
    @cards.inject(0) { |acc, card| acc + card.value }
  end

  def hit(card)
    puts "#{@name} was dealt a #{card.name}"
    @cards << card
    @bust = true if (self.total > 21)
  end

  def list_hand
    puts "#{@name}'s hand:"
    @cards.each { |card| puts "  " + card.name }
  end
end


class Dealer < GenericHand
  def initialize()
    super
    @facedown_card = nil
    @name = "Dealer"
  end

  def deal_facedown(card)
    puts "The dealer deals one card face down to themself."
    @facedown_card = card
  end

  def reveal_card
    @cards << @facedown_card
    @facedown_card = nil
    puts "The dealer turns up the #{@cards[-1].name}"
  end
end

class Player < GenericHand
  def initialize()
    super
    @name = "Player"
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
dealer.hit(deck.deal)
player.hit(deck.deal)
dealer.deal_facedown(deck.deal)

while ( !player.stay ) do
  player.list_hand
  dealer.list_hand

  print "\nHit - h, Stay - s (or any other key): "
  char = gets.chomp
  if char == 'h'
    card = deck.deal
    player.hit(card)
    break if player.bust
  else
    puts "You stay"
    player.stay = true
  end
end

if (player.bust)
  puts "You've gone bust!!! You lose"
  return
else
  puts "It is the dealers turn"
end

dealer.reveal_card

while dealer.total <= 16 do
  dealer.hit(deck.deal)
end

player.list_hand
dealer.list_hand

if (dealer.bust || player.total > dealer.total)
  puts "Player wins"
elsif (player.total == dealer.total)
  puts "Tie game"
else
  puts "Dealer wins"
end
