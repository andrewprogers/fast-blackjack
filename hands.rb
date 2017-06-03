require_relative "deck"
require_relative "card"

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
    ascii_cards = @cards.map { |card| card.ascii_representation.split("\n") }
    loop do
      line = []
      ascii_cards.each { |card| line << card.shift }
      break if line[0].nil?
      puts line.join("  ")
    end
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
    @cards << Card.new(" ", "?")
    @facedown_card = card
  end

  def reveal_card
    @cards.pop()
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
