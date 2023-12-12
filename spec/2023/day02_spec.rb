# frozen_string_literal: true

# spec/2023/hello_world_spec.rb

require_relative '../../lib/2023/day02'

RSpec.describe Day02 do
  let(:line_1) { "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green" }
  let(:line_2) { "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue" }

  describe Line do
    it "returns the Game ID" do
      line = Line.new(line_1)

      expect(line.game_id).to eq(1)
    end

    it "returns a different Game ID" do
      line = Line.new(line_2)

      expect(line.game_id).to eq(2)
    end

    it "returns the game sets" do
      line = Line.new(line_1)
      expected_sets = [
        { blue: 3, red: 4 },
        { red: 1, green: 2, blue: 6 },
        { green: 2 }
      ]

      expect(line.cube_sets).to eq(expected_sets)
    end

    it "returns another game's sets" do
      line = Line.new(line_2)
      expected_sets = [
        { blue: 1, green: 2 },
        { red: 1, green: 3, blue: 4 },
        { green: 1, blue: 1 }
      ]

      expect(line.cube_sets).to eq(expected_sets)
    end

    it "returns the cube totals" do
      line = Line.new(line_1)
      expected_totals = {
        blue: 9,
        red: 5,
        green: 4
      }

      expect(line.cube_totals).to eq(expected_totals)
    end

    it "returns the game" do
      line = Line.new(line_1)
      expected_game = {
        game_id: 1,
        cube_sets: [
          { blue: 3, red: 4 },
          { red: 1, green: 2, blue: 6 },
          { green: 2 }
        ],
        cube_totals: {
          blue: 9,
          red: 5,
          green: 4
        }
      }

      expect(line.game).to eq(expected_game)
    end

    it "returns the second game" do
      line = Line.new(line_2)
      expected_game = {
        game_id: 2,
        cube_sets: [
          { blue: 1, green: 2 },
          { red: 1, green: 3, blue: 4 },
          { green: 1, blue: 1 }
        ],
        cube_totals: {
          blue: 6,
          red: 1,
          green: 6
        }
      }

      expect(line.game).to eq(expected_game)
    end

  end



end
