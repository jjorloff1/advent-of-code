# frozen_string_literal: true

# spec/2023/hello_world_spec.rb

require_relative '../../lib/2023/day02'

RSpec.describe Day02 do
  let(:game_record) { "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green\nGame 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue\nGame 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red\nGame 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red\nGame 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green" }
  let(:game_record_2) { "Game 1: 15 blue, 4 red; 1 red, 2 green, 6 blue; 2 green\nGame 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue\nGame 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red\nGame 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red\nGame 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green" }
  let(:line_1) { "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green" }
  let(:line_2) { "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue" }

  describe Day02 do
    let(:file) { instance_double('file') }

    before { allow(File).to receive(:open).with('input/2023/02/input.txt').and_return(file) }

    it "solves the Day 2 challenge" do
      allow(file).to receive(:read).and_return(game_record)
      expect(described_class.solve).to eq(8)
    end
  end

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

    it "returns the cube maximums" do
      line = Line.new(line_1)
      expected_maximums = {
        blue: 6,
        red: 4,
        green: 2
      }

      expect(line.cube_maximums).to eq(expected_maximums)
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
        cube_maximums: {
          blue: 6,
          red: 4,
          green: 2
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
        cube_maximums: {
          blue: 4,
          red: 1,
          green: 3
        }
      }

      expect(line.game).to eq(expected_game)
    end

  end

  describe GameEvaluator do
    it "identifies when a game is possible" do
      game = {
        cube_maximums: {
          blue: 6,
          red: 4,
          green: 2
        }
      }

      game_evaluator = GameEvaluator.new(game, CUBE_LIMITS)
      expect(game_evaluator.is_game_possible?).to be true
    end

    it "identifies when a game is not possible" do
      game = {
        cube_maximums: {
          blue: 15,
          red: 5,
          green: 4
        }
      }

      game_evaluator = GameEvaluator.new(game, CUBE_LIMITS)
      expect(game_evaluator.is_game_possible?).to be false
    end
  end

  describe AllGamesEvaluator do
    it "sums the game IDs for all valid games" do
      evaluator = AllGamesEvaluator.new(game_record, CUBE_LIMITS)

      expect(evaluator.valid_game_sum).to eq(8)
    end
    it "sums the game IDs for all valid games when first game is invalid" do
      evaluator = AllGamesEvaluator.new(game_record_2, CUBE_LIMITS)

      expect(evaluator.valid_game_sum).to eq(7)
    end
  end



end
