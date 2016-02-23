require "spec_helper"
require "cabral/manhattan_distance"

RSpec.describe Cabral::ManhattanDistance do
  subject { described_class.new(origin, target) }
  Point = Struct.new(:x, :y)

  # [A,1,1]
  # [1,1,1]
  # [1,1,B]
  let(:origin) { Point.new(0,0) }
  let(:target) { Point.new(2,2) }
  it { expect(subject.calculate).to eql(4) }

  context "when just straight east" do
    # [A,1,B]
    # [1,1,1]
    # [1,1,1]
    let(:target) { Point.new(2,0) }
    it { expect(subject.calculate).to eql(2) }
  end

  context "when just straight south" do
    # [A,1,1]
    # [1,1,1]
    # [B,1,1]
    let(:target) { Point.new(0,2) }
    it { expect(subject.calculate).to eql(2) }
  end

  context "when bigger distance" do
    # [A,1,1,1,1,1]
    # [1,1,1,1,1,1]
    # [1,1,1,1,1,1]
    # [1,1,1,1,1,1]
    # [1,1,B,1,1,1]
    # [1,1,1,1,1,1]
    let(:target) { Point.new(2,4) }
    it { expect(subject.calculate).to eql(6) }
  end

  context "when bigger distance (case 2)" do
    # [A,1,1,1,1,1]
    # [1,1,1,1,1,1]
    # [1,1,1,1,1,1]
    # [1,1,1,1,1,B]
    let(:target) { Point.new(4,3) }
    it { expect(subject.calculate).to eql(7) }
  end

  context "when smaller distance" do
    # [A,1]
    # [1,B]
    let(:target) { Point.new(1,1) }
    it { expect(subject.calculate).to eql(2) }
  end
end
