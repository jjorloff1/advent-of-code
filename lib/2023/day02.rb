# frozen_string_literal: true

CUBE_LIMITS = {
  red: 12,
  green: 13,
  blue: 14
}.freeze

class Day02
  def self.solve
    file = File.open('input/2023/02/input.txt')
    game_record = file.read

    AllGamesEvaluator.new(game_record, CUBE_LIMITS).valid_game_sum
  end
end

class Line
  def initialize(line)
    @line = line
  end

  def game_id
    @line[/^Game (\d): .*$/, 1].to_i
  end

  def cube_sets
    sets = @line.split(':')[1]
    sets.split(';').map do |set|
      set_array = set.split(',').map do |cubes|
        { cubes[/(\d+?) (.+)/, 2].to_sym => cubes[/(\d+?) (.+)/, 1].to_i }
      end
      set_array.reduce { |a, b| a.merge(b) }
    end
  end

  def cube_maximums
    cube_sets.reduce do |a, b|
      merged_set = a.clone
      b.each_key do |key|
        merged_set[key] = b[key].to_i if b[key].to_i > merged_set[key].to_i
      end

      merged_set
    end
  end

  def game
    {
      game_id: game_id,
      cube_sets: cube_sets,
      cube_maximums: cube_maximums # could make more efficient by passing cube_sets in
    }
  end
end

class GameEvaluator
  def initialize(game, cube_limits)
    @game = game
    @cube_limits = cube_limits
  end

  def is_game_possible?
    @cube_limits.each do |cube, limit|
      return false if @game[:cube_maximums][cube].to_i > limit.to_i
    end

    true
  end
end

class AllGamesEvaluator
  def initialize(game_record, cube_limits)
    @game_record = game_record
    @cube_limits = cube_limits
  end

  def valid_game_sum
    possible_ids = @game_record.lines.map do |game_line|
      game = Line.new(game_line).game

      GameEvaluator.new(game, @cube_limits).is_game_possible? ? game[:game_id].to_i : 0
    end

    possible_ids.sum
  end
end

puts Day02.solve