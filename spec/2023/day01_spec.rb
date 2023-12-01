# frozen_string_literal: true

# spec/2023/hello_world_spec.rb

require_relative '../../lib/2023/day01'

RSpec.describe Day01 do
  shared_examples 'a document calibration' do |document, expected_value|
    let(:file) { instance_double('file') }
    before { allow(File).to receive(:open).with('input/2023/01/input.txt').and_return(file) }

    it 'provides the calibration value' do
      allow(file).to receive(:read).and_return(document)
      expect(described_class.solve).to eq(expected_value)
    end
  end

  describe Day01 do
    let(:file) { instance_double('file') }

    before { allow(File).to receive(:open).with('input/2023/01/input.txt').and_return(file) }

    it_behaves_like 'a document calibration', "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet", 142
    it_behaves_like 'a document calibration', "1abc2\npqr3stu8vwx", 50
    it_behaves_like 'a document calibration', "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen", 281
  end

  shared_examples 'a line calibration value' do |line, expected_value|
    it do
      line = Line.new(line)
      expect(line.calibration_value).to eq(expected_value)
    end
  end

  describe Line do
    it_behaves_like 'a line calibration value', '1abc2', 12
    it_behaves_like 'a line calibration value', 'pqr3stu8vwx', 38
    it_behaves_like 'a line calibration value', 'a1b2c3d4e5f', 15
    it_behaves_like 'a line calibration value', 'treb7uchet', 77
    it_behaves_like 'a line calibration value', 'two1nine', 29
    it_behaves_like 'a line calibration value', 'eightwothree', 83
    it_behaves_like 'a line calibration value', 'abcone2threexyz', 13
    it_behaves_like 'a line calibration value', 'xtwone3four', 24
    it_behaves_like 'a line calibration value', '4nineeightseven2', 42
    it_behaves_like 'a line calibration value', 'zoneight234', 14
    it_behaves_like 'a line calibration value', '7pqrstsixteen', 76
  end

  describe Calibrator do
    it 'adds the calibration values of all lines' do
      calibrator = described_class.new("1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet")
      expect(calibrator.calibrate_document).to eq(142)
    end

    it 'adds the calibration values of fewer lines' do
      calibrator = described_class.new("1abc2\npqr3stu8vwx")
      expect(calibrator.calibrate_document).to eq(50)
    end
  end
end
