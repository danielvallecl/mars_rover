
require "spec_helper"
require_relative "../mars_rover"
require_relative "../class_mars"

describe "Mars Rover Functions" do

  it 'Checks for the presence of an Input file' do
    rover = MarsRover.new
    expect(rover.read_input_file("mars_input.txt").size).to eq(5)
  end

  it 'Checks if there is a Plateau X and Y Information' do
    rover = MarsRover.new
    expect(rover.read_input_file("mars_input.txt")[0]).to eq("5 5\n")
  end

  

  # it 'A direction other than North, East, South or West' do
  #   rover = Mars.new
  # end
  #
  # it 'A turning command other than Left and Right' do
  #   rover = Mars.new
  # end
  #
  # it 'A Missing Parameter' do
  #   rover = Mars.new
  # end
  #
  # it 'A position over the limits of the plateau' do
  #   rover = Mars.new
  # end

  # it 'Length of String - String Check' do
  #   emptytext = StrFunction.new
  #   str = ""
  #   result = emptytext.len(str)
  #   expect(result).to eq(0)
  # end


end
