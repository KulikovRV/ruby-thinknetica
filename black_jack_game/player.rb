class Player
  attr_reader :name, :cards_hand, :total_points, :bank

  def initialize(name)
    @name = name
    @cards_hand = []
    @score = []
    @total_points
    @bank = 100
  end

  def recive_card(deck)
    @cards_hand << deck.distribute_card
  end 

  def score_points(deck)
    refresh_score
    @cards_hand.each do |card|
      if deck.find_card_value(card).instance_of?(Array)
        deck.find_card_value(card).each do |value|
          if @score.sum >= 11
            @score << 1
            break 
          else 
            @score << 11
            break
          end
        end 
      else 
        @score << deck.find_card_value(card)
      end
    end 
  end

  def calculate_score
    @total_points = @score.sum
  end

  def refresh_score
    @score = []
  end 

  def discard_cards
    @cards_hand = []
  end

  def take_money
    @bank += 10
  end

  def give_money
    @bank -= 10
  end 

  def refresh_money_bank
    @bank = 100
  end 
end
