# frozen_string_literal: true

# spec/2023/hello_world_spec.rb

require_relative '../../lib/2023/day01'

RSpec.describe Day01 do
  let(:long_input) { "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet" }
  let(:short_input) { "1abc2\npqr3stu8vwx" }

  describe Day01 do
    let(:file) { instance_double('file') }

    before { allow(File).to receive(:open).with('input/2023/01/input.txt').and_return(file) }

    it 'provides a calibration value for an input document' do
      allow(file).to receive(:read).and_return(long_input)
      expect(described_class.solve).to eq(142)
    end

    it 'provides a calibration value for an input document with different values' do
      allow(file).to receive(:read).and_return(short_input)
      expect(described_class.solve).to eq(50)
    end
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

    xit 'returns 0 nothing when there are no numbers'
  end

  describe Calibrator do
    it 'adds the calibration values of all lines' do
      calibrator = described_class.new(long_input)
      expect(calibrator.calibrate_document).to eq(142)
    end

    it 'adds the calibration values of fewer lines' do
      calibrator = described_class.new(short_input)
      expect(calibrator.calibrate_document).to eq(50)
    end
  end

end
