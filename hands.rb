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
