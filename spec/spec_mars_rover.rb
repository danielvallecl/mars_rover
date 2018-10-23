=begin

****Structure of the mars_input.txt file****

5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM

=end




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
      letter = input_data[2][0][i]
      expect(letter == "L" || letter == "R" || letter == "M").to eq(true)
      i += 1
    end
  end

  it 'Checks if changing direction is working properly' do
    expect(rover.change_direction("N", "R")).to eq("E")
    expect(rover.change_direction("N", "L")).to eq("W")
    expect(rover.change_direction("W", "R")).to eq("N")
    expect(rover.change_direction("W", "L")).to eq("S")
    expect(rover.change_direction("S", "R")).to eq("W")
    expect(rover.change_direction("S", "L")).to eq("E")
    expect(rover.change_direction("E", "R")).to eq("S")
    expect(rover.change_direction("E", "L")).to eq("N")
  end

  it 'Checks if Move Forward is working properly and within the boundaries' do
    data = rover.move_forward("N", 0, 0)
    expect(data[0]).to eq(0)
    expect(data[1]).to eq(1)

    data = rover.move_forward("S", 0, 0)
    expect(data[0]).to eq(0)
    expect(data[1]).to eq(0)

    data = rover.move_forward("E", 0, 0)
    expect(data[0]).to eq(1)
    expect(data[1]).to eq(0)

    data = rover.move_forward("W", 0, 0)
    expect(data[0]).to eq(0)
    expect(data[1]).to eq(0)

    data = rover.move_forward("N", 5, 5)
    expect(data[0]).to eq(5)
    expect(data[1]).to eq(5)

    data = rover.move_forward("E", 5, 5)
    expect(data[0]).to eq(5)
    expect(data[1]).to eq(5)
  end

  it 'Checks if Move Forward is working properly and within the boundaries' do
    data = rover.run_mars(rover)
  end

end
