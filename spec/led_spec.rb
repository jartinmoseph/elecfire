require './led'
require 'logger'
describe TwinklingLed do
  before :each do
    @this_board = Dino::Board.new(Dino::TxRx.new)
    @log_object = Logger.new('/home/martinpick/delme/elecfile.log', 'daily')
    @log_object.level = 1
    @sample_led = TwinklingLed.new(:led_alive => true, :period_in_secs => 2, :max_period_offset => 0, :mark_space_percent => 30, :led_number => 13, :lifetime => 11, :led_life_start => Time.now, :led_log => @log_object,     :board => @this_board)
  end
  subject {@sample_led}
  xit {should respond_to :retwinkle}
  it {should respond_to :reset_led}
  it {should respond_to :led_alive}
  it {should respond_to :reset_led}
end
