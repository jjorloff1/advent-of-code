# frozen_string_literal: true

# day01.rb

# This is to solve the Day 1 problem for Advent of Code
class Day01
  def self.solve
    file = File.open('input/2023/01/input.txt')
    calibration_document = file.read

    Calibrator.new(calibration_document).calibrate_document
  end
end

# This takes a line and provides the calibration value
class Line
  def initialize(line)
    @line = line
  end

  def calibration_value
    calibration_string = @line[/^\D*?(\d)/, 1] + @line[/(\d)\D*?$/, 1]
    calibration_string.to_i
  end
end

# Calibrator takes a calibration document, and provides the calibration value
class Calibrator
  def initialize(calibration_document)
    @calibration_document = calibration_document
  end

  def calibrate_document
    @calibration_document.lines
                         .map { |line| Line.new(line).calibration_value }
                         .sum
  end
end

puts Day01.solve