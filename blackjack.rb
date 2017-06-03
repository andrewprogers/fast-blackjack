# create a deck of cards
require "pry"

require_relative "card"
require_relative "deck"
require_relative "hands"

class Game
  attr_reader :player, :dealer, :deck
  def initialize()
    @player = Player.new()
    @dealer = Dealer.new()
    @deck = Deck.new()
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

  def play
    deal_initial(@player, @dealer, @deck)
    player_turn(@player, @dealer, @deck)
    dealer_turn(@dealer, @deck) unless @player.bust
    scoring(@player, @dealer)
  end
end

def play_again?
  loop do
    print "\nPlay again(y/n)? "
    user_input = gets.chomp.downcase
    return true if user_input == 'y'
    return false if user_input == 'n'
    puts "Invalid entry, try again"
  end
end

puts "Welcome to Blackjack."
puts "----------------------------\n\n"
loop do
  Game.new().play()
  break unless play_again?
end
