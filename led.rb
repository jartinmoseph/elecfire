require 'dino'
require 'logger'
require 'rspec'
class Conflagration
  attr_reader :active_led_nos
  attr_reader :log

  def initialize(options={})
    #puts "initialize: options is " + options.inspect
    @log = options[:log_object]
    @active_led_nos = options[:active_led_nos]
    @fuel_percent = options[:fuel_percent]
    @vent_open_percent = options[:vent_open_percent]
    @heat_percent = options[:heat_percent]
    @ash_percent = options[:ash_percent]
    @board = options[:this_board]
    @lifetime = options[:lifetime]
    @lifetime_offset = options[:lifetime_offset]
    #puts "conflagration init: @log is " + @log.inspect
    @log.debug options.inspect + "the options hash"
    @log.info "the active leds are: " + @active_led_nos.inspect 
    @start_time = Time.now
    self.set_up_leds
    #self.reset_leds_if_needed
    #@log.info("initialize: @led_objects is " + @led_objects.inspect)
    #self.twinkle(@led_objects)

    @initial_params = Hash.new(:log_object => options[:led_log],
    :led_alive => true,
    :period_in_secs => options[:period_in_secs].to_f,
    :max_period_offset => options[:max_period_offset],
    :mark_space => (options[:mark_space_percent].to_f)/100,
    :lifetime => options[:lifetime],
    :led_life_start => Time.now,
    :board => options[:board],
    #:this_led => Dino::Components::Led.new(pin: @led_number, board: @board),
    :changeover_time => Time.now)
  end  
  def set_up_leds
    @log.info("in set_up_leds: @active_led_nos is " + @active_led_nos.inspect)
    @led_objects = @active_led_nos #both are arrays
  end
  def configure_leds
    @led_objects.each do |this_led_object|
      if this_led_object == nil #set up the TwinklingLed object with some arbitrary values - add variables later
        this_led_object == TwinklingLed.new(@initial_parms)
        this_led_object.led_number
        #this_led_object == TwinklingLed.new(:lifetime => 11, :period_in_secs => 3, :max_period_offset => 2, :mark_space_percent => 75, :led_number => ghgh, :board => @board, :led_log => @log)
      elsif this_led_object.alive == false
        this_led_object.reset_led(twinkle_params)
      else 
        #do nothing if exists and is alive, though it shouldn't have entered this if statement
      end  
    end
  end
=begin
  def reset_leds_if_needed
    @active_led_nos.each do |ghgh|
      @log.info "in set_up_leds_1: checking whether reset is required for led no " + ghgh.inspect
      if @led_objects[ghgh] == nil
        @log.info "set_up_leds_2: TwinklingLed object no " + ghgh.inspect + " is nil, so creating it"
        #@led_objects[ghgh] = TwinklingLed.new(:lifetime => 11, :period_in_secs => 3, :max_period_offset => 2, :mark_space_percent => 75, :led_number => ghgh, :board => @board, :led_log => @log)
      elsif @led_objects[ghgh].alive
        @log.info "set_up_leds_3: TwinklingLed object no " + ghgh.inspect + " is alive"
      else
        @log.info "set_up_leds_4: TwinklingLed object no " + ghgh.inspect + " else "
        #@led_objects[ghgh] = TwinklingLed.new(:lifetime => 11,:period_in_secs => 3, :max_period_offset => 2, :mark_space_percent => 75, :led_number => ghgh, :board => @board, :led_log => @log)
      end
      @log.debug "in set_up_leds_5; led_objects is " + @led_objects.inspect
    end
    return @led_objects
  end
=end
  def twinkle(leds_to_twinkle) #leds_to_twinkle is an array of TwinklingLed objects
    @log.info "twinkle_2"
    while 1
      @log.info "twinkle_1; leds_to_twinkle is " + leds_to_twinkle.inspect + " of class " + leds_to_twinkle.class.inspect
      @log.info "twinkle_2_1"
      leds_to_twinkle.each do |this_led_object|
	@log.info "twinkle_2_2: led number is " + this_led_object.led_number.inspect
        unless this_led_object == nil
	  @log.info "twinkle_3: led number is " + this_led_object.led_number.inspect
	  if this_led_object.led_alive
            @log.info "twinkle_3_3: led number is " + this_led_object.led_number.inspect + " and this_led_object.led_alive appears to be true: " + this_led_object.led_alive.inspect
            this_led_object.update(Time.now) 
            @log.info "twinkle_3_2: led number is " + this_led_object.led_number.inspect + " and having been updated, this_led_object.led_alive should be false: " + this_led_object.led_alive.inspect 
          else
	    @log.info "twinkle_3_1: led number is " + this_led_object.led_number.inspect + " and this_led_object.led_alive appears to be false: " + this_led_object.led_alive.inspect + " so it needs retwinkling "
            #self.reset_leds_if_needed
            #this_led_object.retwinkle

          end
	  @log.debug "twinkle_4: led number is " + this_led_object.led_number.inspect
        end
=begin
        if (this_led_object == nil || this_led_object.led_alive == false)
        else this_led_object.update(Time.now) 
        end
=end
      end
      sleep 0.1
    end
  end
end

class TwinklingLed
  attr_reader :led_alive
  attr_reader :led_number
  attr_reader :log_object

  def initialize(options={})
    #puts "twinkling_led_initialize_options: " + options.inspect
    #puts "twinkling_led_initialize_led_log: " + options[:led_log].inspect
    @log_object = options[:led_log]
    #puts "twinkling_led_initialize_log_object: " + @log_object.inspect
    @led_alive = true
    @period_in_secs = options[:period_in_secs].to_f
    @max_period_offset = options[:max_period_offset]
    @mark_space = (options[:mark_space_percent].to_f)/100
    @led_number = options[:led_number]
    @lifetime = options[:lifetime]
    @led_life_start = Time.now
    @board = options[:board]
    @log_object.info "twinkling_led_initialize: led_number is " + @led_number.inspect# + " board is " + @board.inspect
    @this_led = Dino::Components::Led.new(pin: @led_number, board: @board)
    @changeover_time = Time.now
    @log_object.info "twinkling_led_initialize: changeover_time: " + @changeover_time.inspect 
  end

  def reset_led(params)
        #this_led_object == TwinklingLed.new(:lifetime => 11, :period_in_secs => 3, :max_period_offset => 2, :mark_space_percent => 75, :led_number => ghgh, :board => @board, :led_log => @log)
        
  end
  def update time_now
    @log_object.info "update_1"
    if time_now > @changeover_time
      @log_object.info "update_2 about to do changeover"
      self.do_changeover
      @log_object.info "update_3 changeover done"
    end
  end
  def do_changeover  
    @log_object.info "changeover_1"
    @rand_offset = rand @max_period_offset
    @on_time =  (@rand_offset + @period_in_secs) * @mark_space
    @off_time = (@rand_offset + @period_in_secs) * (1 - @mark_space)
    @log_object.info("changover: on_time: " + @on_time.inspect + " off_time: " + @off_time.inspect + " @max_period_offset: " + @max_period_offset.inspect + " @rand_offset: " + @rand_offset.inspect + " @mark_space " + @mark_space.inspect)
    if Time.now - @led_life_start < @lifetime
      if @led_is_on
        @changeover_time = Time.now + @off_time
        @this_led.send(:off)
        @led_is_on = false
        @log_object.info("changeover: led " + @led_number.to_s + " has just gone off")
      else
        @changeover_time = Time.now + @on_time
        @this_led.send(:on)
        @led_is_on = true
        @log_object.info("changeover: led " + @led_number.to_s + " has just come on")
      end
    else
      @led_alive = false
      @this_led.send(:off)
    end
  end
end


