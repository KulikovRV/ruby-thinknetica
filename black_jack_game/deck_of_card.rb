class DeckOfCard
  attr_reader :cards, :cost_of_cards, :mixed_deck
  
  def initialize(deck, cost_of_cards)
    @cards = deck
    @cost_of_cards = cost_of_cards
    @mixed_deck
  end 

  def shuffle_cards
    @mixed_deck = cards.shuffle
  end

  def distribute_card
    mixed_deck.pop
  end 

  def find_card_value(card)
    @cost_of_cards[card]
  end 
end
