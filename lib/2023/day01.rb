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
  DIGIT_TO_WORD = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9
  }.freeze

  FIRST_DIGIT_REGEX = /^\D*?(\d|one|two|three|four|five|six|seven|eight|nine)/
  # Reverse regex for matching a reversed string
  LAST_DIGIT_REGEX = /^\D*?(\d|enin|thgie|neves|xis|evif|ruof|eerht|owt|eno)/

  def initialize(line)
    @line = line
  end

  def calibration_value
    first_digit = digit_value(@line[FIRST_DIGIT_REGEX, 1])
    # Rather than figure out a pretty complex regex to get the last number, I decided to use the
    # easy first number regex by reversing the strings
    last_digit = digit_value(@line.reverse[LAST_DIGIT_REGEX, 1].reverse)

    calibration_string = first_digit.to_s + last_digit.to_s
    calibration_string.to_i
  end

  private

  def digit_value(digit_string)
    (DIGIT_TO_WORD[digit_string].nil? ? digit_string.to_i : DIGIT_TO_WORD[digit_string])
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
