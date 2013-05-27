# coding: utf-8

require "spec_helper"


describe "ToyRobot" do
  
  let(:robot) do
    ToyRobot.new
  end
  
  
  it "should place the robot on the table with the PLACE command" do
    robot.parse('PLACE 0,4,SOUTH')
    robot.parse('REPORT').should eq('0,4,SOUTH')
    robot.parse('PLACE 0,0,SOUTH')
    robot.parse('REPORT').should eq('0,0,SOUTH')
    robot.parse('PLACE 4,3,NORTH')
    robot.parse('REPORT').should eq('4,3,NORTH')
    robot.parse('PLACE 1,1,WEST')
    robot.parse('REPORT').should eq('1,1,WEST')
  end
  
  it "should ignore any commands until a valid PLACE command was given" do
    robot.parse('MOVE').should eq('Robot not placed yet')
    robot.parse('PLAC 1,1,WEST')
    robot.parse('MOVE').should eq('Robot not placed yet')
    robot.parse('MOVE').should eq('Robot not placed yet')
    robot.parse('LEFT').should eq('Robot not placed yet')
    robot.parse('LEFT').should eq('Robot not placed yet')
    robot.parse('REPORT').should eq('Robot not placed yet')
    robot.parse('PLACE 1,1,WEST')
    robot.parse('REPORT').should eq('1,1,WEST')
  end
  
  it "should move an existing robot with the MOVE command" do
    robot.parse('PLACE 1,1,WEST')
    robot.parse('MOVE')
    robot.parse('REPORT').should eq('0,1,WEST')
    robot.parse('RIGHT')
    robot.parse('MOVE')
    robot.parse('REPORT').should eq('0,2,NORTH')
  end
  
  it "should turn the robot left with the LEFT command" do
    robot.parse('PLACE 1,1,WEST')
    robot.parse('LEFT')
    robot.parse('REPORT').should eq('1,1,SOUTH')
    robot.parse('LEFT')
    robot.parse('REPORT').should eq('1,1,EAST')
  end
  
  it "should turn the robot right with the RIGHT command" do
    robot.parse('PLACE 3,0,EAST')
    robot.parse('RIGHT')
    robot.parse('REPORT').should eq('3,0,SOUTH')
    robot.parse('RIGHT')
    robot.parse('REPORT').should eq('3,0,WEST')
  end
  
  it "should print the current location and direction with the REPORT command" do
    robot.parse('PLACE 3,0,EAST')
    robot.parse('REPORT').should eq('3,0,EAST')
    robot.parse('PLACE 0,0,SOUTH')
    robot.parse('REPORT').should eq('0,0,SOUTH')
    robot.parse('PLACE 4,4,WEST')
    robot.parse('MOVE')
    robot.parse('MOVE')
    robot.parse('REPORT').should eq('2,4,WEST')
  end
  
  it "should ignore invalid commands" do
    robot.parse('PUT 0,0,NORTH').should eq('Invalid command')
    robot.parse('PLACE 0,0,SOUTHWEST').should eq('Invalid command')
    robot.parse('').should eq('Invalid command')
    robot.parse('PUT 0,0,NORTH').should eq('Invalid command')
    robot.parse('PUT 0,0,NORTH').should eq('Invalid command')
    robot.parse('PUT 0,0,NORTH').should eq('Invalid command')
    robot.parse('PUT 0,0,NORTH').should eq('Invalid command')
  end
  
  it "should ignore commands that would move the robot beyond the tabletop" do
    robot.parse('PLACE 0,5,NORTH').should eq('Invalid y coordinate')
    robot.parse('PLACE 5,0,NORTH').should eq('Invalid x coordinate')
    robot.parse('PLACE 0,4,WEST')
    robot.parse('MOVE').should eq("Can't go further this way")
    robot.parse('PLACE 1,0,SOUTH')
    robot.parse('MOVE').should eq("Can't go further this way")
    robot.parse('PLACE 1,4,NORTH')
    robot.parse('MOVE').should eq("Can't go further this way")
    robot.parse('PLACE 4,0,EAST')
    robot.parse('MOVE').should eq("Can't go further this way")
  end
  
  it "should successfully pass example a)" do
    robot.parse('PLACE 0,0,NORTH')
    robot.parse('MOVE')
    robot.parse('REPORT').should eq('0,1,NORTH')
  end
  
  it "should successfully pass example b)" do
    robot.parse('PLACE 0,0,NORTH')
    robot.parse('LEFT')
    robot.parse('REPORT').should eq('0,0,WEST')
  end
  
  it "should successfully pass example c)" do
    robot.parse('PLACE 1,2,EAST')
    robot.parse('MOVE')
    robot.parse('MOVE')
    robot.parse('LEFT')
    robot.parse('MOVE')
    robot.parse('REPORT').should eq('3,3,NORTH')
  end
  
end