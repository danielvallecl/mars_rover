
require "spec_helper"
require_relative "../mars_rover"
require_relative "../class_mars"

describe "Mars Rover Functions" do

  rover = MarsRover.new
  input_data = rover.read_input_file("mars_input.txt")

  it 'Checks for the presence of an Input file' do
    expect(input_data.size).to eq(5)
  end

  it 'Checks if there is a Plateau X and Y Information' do
    expect(input_data[0]).to eq("5 5\n")
  end

  it 'Checks if there are Rovers set in the Input File' do
    expect((input_data.size - 1) / 2).to eq(2)
  end

  it 'Checks if the X, Y position are Integers' do
    expect(input_data[1][0].to_i).to be_an_instance_of(Integer)
    expect(input_data[1][2].to_i).to be_an_instance_of(Integer)
  end

  it 'Checks if the direction commands are valid' do
    i = 0
    while i < input_data[2][0].length do
      expect(input_data[2][0][i]).to be_an_instance_of(String)
      i += 1
    end
  end




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
