# frozen_string_literal: true

require_relative 'modules/manufacturer_name'
require_relative 'modules/instance_counter'
require_relative 'modules/valid'
require_relative 'train'
require_relative 'vagon'
require_relative 'cargo_train'
require_relative 'passanger_train'
require_relative 'passanger_vagon'
require_relative 'cargo_vagon'
require_relative 'station'
require_relative 'route'
require_relative 'controller'

controller = Controller.new
controller.help
controller.run
