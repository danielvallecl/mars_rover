=begin
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Request from Yroo - Rover squad moves on Mars Plateau
*
* Code written by: Daniel Valle
* Date: 2018-10-22
* Location: Toronto - Canada
* Version: MarsRover_v1.0
* Development environment: Mac Osx - Ruby 2.5
* Test environment: TDD - Rspec
* Version control - Github - repository
*
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*
* Directory structure:
*          mars_rover
*              mars_rover.rb         - Main
*              mars_input.txt        - input data sample
*              class_mars.rb         - class definition
*              README.md             - Application information
*          spec
*            spec_helper.rb          - Rspec helper
*            spec_mars_rover.rb      - Application tests
*
*
* How to operate - Application:
*
* From the cli - > ruby mars_rover.rb 'ARG'
*                'ARG' = filename with rovers data
*
* Ex: > ruby mars_rover.rb 'mars_input.txt'
*       ('mars_input.txt' is present in the marsRover Github repository )
*
* 'test.txt' file was used as one of the tests to check the boundaries of the plateau
*
* How to operate - Tests:
*
* From the cli - > rspec spec/spec_mars_rover.rb
*
*
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*
* Required information - Class MarsRover - All functions to process rover commands
* Filename - Name of the input file with rover's commands data
* Rovers accept commands to move and rotate to previously validated position.
* Rovers accept moves that will end out of the Plateau's boundaries but rovers will stop at the edge of the limits.
*
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
=end

# Aplication initialization: Instantiates the MarsRover class, reads the input file and
# validates the input data.
# Exit the initialization, returning false, if file not found and if input data format out of spec.
# requires class MarsRover and its methods
require_relative 'class_mars.rb'

X_POS = 0
Y_POS = 1
DIRECTION = 2

mars = MarsRover.new
filename = ARGV[0]
input_data = mars.read_input_file(filename)
if !mars.read_input_file(filename)
  return false
end
if !mars.data_input_validation(input_data)
  return false
end

# View rovers final position after executing all received commands.
rovers_final_position = mars.run_rover()
rover = 0
while rover < rovers_final_position.size
  puts "#{rovers_final_position[rover][X_POS]} #{rovers_final_position[rover][Y_POS]} #{rovers_final_position[rover][DIRECTION]}"
  rover += 1
end
