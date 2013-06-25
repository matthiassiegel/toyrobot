# coding: utf-8

#
# Author: Matthias Siegel (matthias.siegel@gmail.com)
#

class ToyRobot
  
  def initialize
    @x = 0
    @y = 0
    @direction = ''
  end
  
  #
  # Parse toy robot commands
  #
  # @param [String]
  # @return [String]
  #
  def parse(input)
    input.chomp!
    
    # PLACE x,y,direction
    if input =~ /^place\s+([-|+]?\d)\s*,\s*([-|+]?\d)\s*,\s*(north|east|south|west){1}$/i
      place($1.to_i, $2.to_i, $3.downcase)
    
    # MOVE, LEFT, RIGHT, REPORT
    elsif input =~ /^(move|left|right|report)$/i
      not_placed? ? errors[:not_placed] : send($1.to_sym)
    
    # EXIT
    elsif input =~ /^exit$/i
      raise SystemExit
  
    else
      errors[:invalid]
    end
  end
  
  
  
  private
  
  
  def place(x, y, direction)
    return errors[:invalid_x] if x < 0 || x > 4
    return errors[:invalid_y] if y < 0 || y > 4
    
    @x = x
    @y = y
    @direction = direction
    
    report
  end
  
  def move
    case @direction
    when 'north'
      return errors[:too_far] if @y == 4
      @y += 1
    when 'east'
      return errors[:too_far] if @x == 4
      @x += 1
    when 'south'
      return errors[:too_far] if @y == 0
      @y -= 1
    when 'west'
      return errors[:too_far] if @x == 0
      @x -= 1
    end
    
    report
  end
  
  def left
    @direction = directions[index == 0 ? 3 : index - 1]
    report
  end
  
  def right
    @direction = directions[index == 3 ? 0 : index + 1]
    report
  end
  
  def report
    "#{@x},#{@y},#{@direction.upcase}"
  end
  
  def index
    directions.index(@direction)
  end
  
  def not_placed?
    @direction.length == 0
  end
  
  def directions
    ['north', 'east', 'south', 'west']
  end
  
  def errors
    {
      invalid: "Invalid command",
      invalid_x: "Invalid x coordinate",
      invalid_y: "Invalid y coordinate",
      not_placed: "Robot not placed yet",
      too_far: "Can't go further this way"
    }
  end
    
end