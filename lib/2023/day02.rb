# frozen_string_literal: true

class Day02
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

  def cube_totals
    cube_sets.reduce do |a, b|
      merged_set = a.clone
      b.each_key do |key|
        merged_set[key] = merged_set[key].to_i + b[key].to_i
      end

      merged_set
    end
  end

  def game
    {
      game_id: game_id,
      cube_sets: cube_sets,
      cube_totals: cube_totals # could make more efficient by passing cube_sets in
    }
  end
end
