=begin
Class MarsRover - All functions to process rover commands
*
* Available Methods:
*
* get_rover_data: parameters: none
*
*                 Returns all data read from the input file
*
* change_direction: parameters: current_direction and command
*
*                 Returns new direction based in the command input
*
* move_forward: parameters: current_direction, x_pos and y_pos)
*
*                 Returns new position based in the command input
*
* data_input_validation: parameters: input_array read from input file
*
*                 Returns false for a failing Validation
*                         array with input file data if pass validation
*
* def read_input_file: parameters: filename that comes from cli argument
*
                 Returns an array with input file data
*
*
*
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
=end

class MarsRover

  @x_pos
  @y_pos
  @number_of_rovers
  @rovers_data
  @x_lim
  @y_lim

  def initialize()
    @x_lim = 5
    @y_lim = 5
  end

  def get_rover_data
    return @rovers_data
  end

  # Gets the current direction and sets a new one based on the input command
  # Array [N,E,S,W] used to convert value in the index to improve positioning process
  def change_direction(current_direction,command)
    cardinals = ["N","E","S","W"]
    number = cardinals.index(current_direction)
    case command
      when 'L'
        if number >= 1
          number -= 1
          direction = cardinals[number]
        else
          number = 3
          direction = cardinals[number]
        end
      when 'R'
          if number <= 2
            number += 1
            direction = cardinals[number]
          else
            number = 0
            direction = cardinals[number]
          end
    end
    return direction
  end

  # Gets the current position and sets a new one based on the input command
  # Array [N,E,S,W] used to convert value in the index to improve positioning process

  def move_forward(current_direction,x_pos, y_pos)
    cardinals = ["N","E","S","W"]
    number = cardinals.index(current_direction)
    case number

    when 0
        if y_pos + 1 <= @y_lim
          y_pos += 1
        end
      when 1
        if x_pos + 1 <= @x_lim
          x_pos += 1
        end
      when 2
        if y_pos - 1 >= 0
          y_pos -= 1
        end
      when 3
        if x_pos - 1 >= 0
          x_pos -= 1
        end
    end
    return [x_pos, y_pos]
  end




  # Validates the size of the Plateau, the position integers input, the allowed directions and commands
  def data_input_validation(input_array)
    ok = true
    limit = input_array[0].split(' ')
    if limit.size == 2
      @x_lim = limit[0].to_i
      @y_lim = limit[1].to_i
    else
      ok = false
      return ok
    end
    if @x_lim == 0 && limit[0] != '0'
        ok = false
    end
    if @y_lim == 0 && limit[1] != '0'
        ok = false
    end

    valid_rovers = []
    rovers_data = []
    number_of_rovers = ((input_array.size) -1 )
    @number_of_rovers = number_of_rovers / 2
    i = 1
    while i < number_of_rovers

      position = input_array[i].split(' ')
      x_pos = position[0].to_i
      y_pos = position[1].to_i
      direction = position[2]
      if x_pos == 0 && position[0] != '0'
          ok = false
      end
      if y_pos == 0 && position[1] != '0'
          ok = false
      end
      if direction != 'N' && direction != 'S' && direction != 'E' && direction != 'W'
        ok = false
      end

      command = input_array[i+1]
      if command.strip == ''
        ok = false
      end
      j = 0
      while j < command.length - 1
        if command[j] != 'L' && command[j] != 'R' && command[j] != 'M'
          ok = false
        end
        j += 1
      end

      valid_rovers.push(ok)
      data = [x_pos, y_pos, direction, command]
      rovers_data.push(data)
      ok = true
      i += 2
    end
    @rovers_data = rovers_data
    return valid_rovers
  end


  # Reads input data from a file specified in the cli
  def read_input_file(filename)
    begin
      input_array = []
      text=File.open(filename).read
      text.gsub!(/\r\n?/, "\n")
      text.each_line do |line|
        input_array.push(line)
      end
    rescue
      return false
    end
    return input_array
  end
end
