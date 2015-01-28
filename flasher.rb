require './led.rb'
require 'dino'
require 'logger'

@this_board = Dino::Board.new(Dino::TxRx.new)
@log_object = Logger.new('/home/martinpick/delme/elecfile.log', 'daily')
@log_object.level = Logger::INFO
the_fire = Conflagration.new(:this_board => @this_board, :fuel => 100, :vent_open_percent => 100, :heat_percent => 0, :ash_percent => 0, :active_led_nos => [9,10], :speed => 100, :lifetime => 5, :lifetime_offset => 3, :log_object => @log_object)
