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

  def list_hand
    super
    puts "  ...and one face down card" unless @facedown_card.nil?
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
  puts "----------------------------\n\n"
end

def deal_initial(player, dealer, deck)
  puts "The dealer deals you your hand."
  player.hit(deck.deal)
  dealer.hit(deck.deal)
  player.hit(deck.deal)
  dealer.deal_facedown(deck.deal)
  puts "\n"
end

def show_hands(*hands)
  hands.each { |hand| hand.list_hand }
end

def player_turn(player, dealer, deck)
  while ( !player.stay ) do
    show_hands(player, dealer)

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
end

def dealer_turn(dealer, deck)
  puts "It is the dealers turn"
  dealer.reveal_card
  while dealer.total <= 16 do
    dealer.hit(deck.deal)
  end
end

def scoring(player, dealer)
  puts "Final Hands:"
  show_hands(player, dealer)
  if player.bust
    puts "You went bust, dealer wins"
  elsif dealer.bust
    puts "Dealer goes bust, player wins"
  else
    p_score = player.total
    d_score = dealer.total
    puts "Player: #{p_score}. Dealer: #{d_score}."
    if p_score > d_score
      puts "Player wins"
    elsif d_score > p_score
      puts "Dealer wins"
    else
      puts "Tie game"
    end
  end
end


print_title

player = Player.new()
dealer = Dealer.new()
deck = Deck.new()

deal_initial(player, dealer, deck)
player_turn(player, dealer, deck)
dealer_turn(dealer, deck) unless player.bust
scoring(player, dealer)
