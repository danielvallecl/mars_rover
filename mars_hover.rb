=begin
* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Request from Yroo
*
* Code written by: Daniel Valle
* Date: 2018-10-22
* Location: Toronto - Canada
* Version: MarsRover_v1.0
* Development environment: Mac Osx - Ruby 2.5
*
*
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Class MarsRover - All functions to process rover commands
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


# Aplication initialization: Instantiates the MarsRover class, reads the input file and
# validates the input data.
# Exit the initialization if file not found and if input data format out of spec.
require_relative 'class_mars.rb'

mars = MarsRover.new
filename = ARGV[0]
input_data = mars.read_input_file(filename)
if input_data != false
  result = mars.data_input_validation(input_data)
else
  puts "File does not exist!"
end
if !result
  puts "Input file data out of spec!"
  return false
end

# Gets all the data relative to the rovers. That is no limit to the size of the rovers squad.
# iterates over rover's data.
# If there is no moves "M" commands to the rover, we will present initial rover's location
rover_data = mars.get_rover_data
rover = 0
number_of_rovers = rover_data.size
while rover <  number_of_rovers
    direction = ''
    new_position = ''
    process_cmd = 0
    while process_cmd < rover_data[rover][3].length - 1
      data = rover_data[rover][3][process_cmd]
      case data
        when "L", "R"
          direction = rover_data[rover][2]
          new_direction = mars.change_direction(direction,data)
          rover_data[rover][2] = new_direction
        when "M"
          direction = rover_data[rover][2]
          new_position = mars.move_forward(direction, rover_data[rover][0], rover_data[rover][1])
          rover_data[rover][0] = new_position[0]
          rover_data[rover][1] = new_position[1]
      end
      process_cmd += 1
    end
    if new_position != nil && new_position != ''
      puts "#{new_position[0]} #{new_position[1]} #{new_direction}"
    else
      puts "#{rover_data[rover][0]} #{rover_data[rover][1]} #{new_direction}"
    end
    rover += 1
end
