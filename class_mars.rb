=begin
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Request from Yroo - Mars rover
*
* Code written by: Daniel Valle
* Date: 2018-10-23
* Location: Toronto - Canada
* Version: MarsRover_v1.0
* Development environment: Mac Osx - Ruby 2.5
* Test environment: TDD - Rspec
*
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*                             Class MarsRover - All functions to process rover commands
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
*                         array with input file data if validation passes
*
* def read_input_file: parameters: filename that comes from cli argument
*
*                 Returns an array with input file data
*
* run_rover: parameters: instance of MarsRover
*
*                 Returns x position, y position and direction of all rovers
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
=end

class MarsRover

    # Class MarsRover attributes
    attr_accessor :valid_rovers
    attr_accessor :number_of_rovers
    attr_accessor :rovers_data
    attr_accessor :x_lim
    attr_accessor :y_lim
    attr_accessor :test_rovers_data
    attr_accessor :x_pos
    attr_accessor :y_pos
    @valid_rovers = []
    @number_of_rovers = 0
    @rovers_data = []

  def initialize()
    self.x_pos = 0
    self.y_pos = 0
    self.x_lim = 5
    self.y_lim = 5
  end


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Passes all rover input_data to the main block of the application
  def get_rover_data
    if self.rovers_data != nil
      return self.rovers_data
    else
      self.test_rovers_data = [[1,2,'N','LMLMLMLMM\n'],[3,3,'E','MMRMMRMRRM\n']]
      return self.test_rovers_data
    end
  end


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Gets the current position and sets a new one based on the input command
  # Array [N,E,S,W] used to convert value in the index to improve positioning process
  def move_forward(current_direction,x_pos, y_pos)
    cardinals = ["N","E","S","W"]
    number = cardinals.index(current_direction)
    case number
      when 0
        if y_pos + 1 <= self.y_lim
          y_pos += 1
        end
      when 1
        if x_pos + 1 <= self.x_lim
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


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Validates the size of the Plateau, the position integers input, the allowed directions and commands
  # Position data must be within the valid Integer range as specified in the book of requirements
  def data_input_validation(input_array)
    ok = true
    # Validates the limits of the Plateau
    limit = input_array[0].split(' ')
    if limit.size == 2
      self.x_lim = limit[0].to_i
      self.y_lim = limit[1].to_i
    else
      ok = false
      return ok
    end
    if self.x_lim == 0 && limit[0] != '0'
        ok = false
    end
    if self.y_lim == 0 && limit[1] != '0'
        ok = false
    end
    if self.x_lim < 0 || self.y_lim < 0
      ok = false
    end
    # Validates position and direction for the rover moves
    self.valid_rovers = []
    rovers_data = []
    number_of_rovers = ((input_array.size) -1 )
    self.number_of_rovers = number_of_rovers / 2
    i = 1
    while i < number_of_rovers
      position = input_array[i].split(' ')
      if position.size == 3
        x_pos = position[0].to_i
        y_pos = position[1].to_i
        direction = position[2]
      else
        ok = false
      end
      if x_pos == 0 && position[0] != '0'
          ok = false
      end
      if y_pos == 0 && position[1] != '0'
          ok = false
      end
      if direction != 'N' && direction != 'S' && direction != 'E' && direction != 'W'
        ok = false
      end
      # Validates commands, from the input file, destinated to rotate and move the rovers
      command = input_array[i+1]
      # Empty line of command - Do nothing
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
      # Save status of the rover's data
      self.valid_rovers.push(ok)
      data = [x_pos, y_pos, direction, command]
      rovers_data.push(data)
      ok = true
      i += 2
    end
    #self.rovers_data -> all validated data for rover
    self.rovers_data = rovers_data
    return self.valid_rovers
  end


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Run all rovers commands received from the input file after appropriate validation of the data.
  # run_rover utilizes array valid_rovers to process only commands pre-validated - true - process, false - skip
  # returns an array - output_buffer with x position, y position and direction of all rovers.
  def run_rover(validation = nil)
    # Validation argument sent by Rspec for testing the method.
    if validation != nil
      self.valid_rovers = validation
    end
    rover_data = self.get_rover_data
    output_buffer = []
    rover = 0
    number_of_rovers = rover_data.size
    while rover <  number_of_rovers
      if self.valid_rovers[rover] != false
        new_position = ''
        new_direction = ''
        process_cmd = 0
        while process_cmd < rover_data[rover][3].length - 1
          data = rover_data[rover][3][process_cmd]
          case data
            when "L", "R"
              direction = rover_data[rover][2]
              new_direction = self.change_direction(direction,data)
              rover_data[rover][2] = new_direction
            when "M"
              direction = rover_data[rover][2]
              new_position = self.move_forward(direction, rover_data[rover][0], rover_data[rover][1])
              rover_data[rover][0] = new_position[0]
              rover_data[rover][1] = new_position[1]
          end
          process_cmd += 1
        end
        # if new_position != nil && new_position != ''
          new_position = [rover_data[rover][0],rover_data[rover][1]]
        # end
        if new_direction == ''
          new_direction = direction
        end
        output_buffer.push([new_position[0],new_position[1],new_direction])
      end
      rover += 1
    end
    return output_buffer
  end


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Reads input data from a file - filename specified in the cli through an argument
  def read_input_file(filename)
    begin
      input_array = []
      commands = File.open(filename).read
      commands.gsub!(/\r\n?/, "\n")
      commands.each_line do |line|
        input_array.push(line)
      end
    rescue
      return false
    end
    return input_array
  end


end
