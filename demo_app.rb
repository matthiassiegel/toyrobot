# coding: utf-8

#
# Author: Matthias Siegel (matthias.siegel@gmail.com)
#

require File.dirname(__FILE__) + '/lib/toy_robot.rb'

puts "\n"
puts "Enter commands:"
puts "\n"


toy_robot = ToyRobot.new

while input = STDIN.gets do
  begin
    puts "=> #{toy_robot.parse(input)}"
  rescue SystemExit
    break
  end
end