require_relative 'cards'
require_relative 'deck_of_card'
require_relative 'cost_of_cards'
require_relative 'player'
require_relative 'dealer'
require_relative 'controller'

controller = Controller.new
controller.run
