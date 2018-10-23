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
  return false
end

output = mars.run_mars(mars)
rover = 0

while rover < output.size do
 puts "#{output[rover][0]} #{output[rover][1]} #{output[rover][2]}"
 rover += 1
end
