require './led'
require 'logger'
describe Conflagration do
  before :each do
    @this_board = Dino::Board.new(Dino::TxRx.new)
    @log_object = Logger.new('/home/martinpick/delme/elecfile.log', 'daily')
    @log_object.level = 1
    @samplefire = Conflagration.new(:this_board => @this_board,  :fuel => 100,  :vent_open_percent => 100, :heat_percent => 0, :ash_percent => 0, :active_led_nos => [9,10], :speed => 100, :lifetime => 5, :lifetime_offset => 3, :log_object => @log_object)
  end
  subject {@samplefire}
  it {should respond_to :log}
  it {should respond_to :configure_leds}

  xit {should respond_to :active_led_nos}
  xit {should respond_to :twinkle}
  xit "should have the right active led numbers" do
    @samplefire.active_led_nos == [9,10]
  end
end
