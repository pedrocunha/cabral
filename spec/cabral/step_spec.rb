require "spec_helper"
require "cabral/step"
require "cabral/point"

RSpec.describe Cabral::Step do
  let(:map) do
    [
      [0,1,4],
      [1,1,2],
      [1,1,1]
    ]
  end

  let(:point)     { Cabral::Point.new(0,0) }
  let(:objective) { Cabral::Point.new(2,2) }

  subject { described_class.new(map, point, objective) }

  it { expect(subject.x).to eql(0) }
  it { expect(subject.y).to eql(0) }
  it { expect(subject.g).to eql(0) }
  it { expect(subject.h).to eql(4) }
  it { expect(subject.f).to eql(4) }

  context "when it moves to east" do
    let(:east) { subject.east }

    it { expect(east.x).to eql(1) }
    it { expect(east.y).to eql(0) }
    it { expect(east.g).to eql(1) }
    it { expect(east.h).to eql(3) }
    it { expect(east.f).to eql(4) }
  end

  context "when accumulates cost of movement" do
    let(:moving) { subject.east.east }

    it { expect(moving.x).to eql(2) }
    it { expect(moving.y).to eql(0) }
    it { expect(moving.g).to eql(5) }
    it { expect(moving.h).to eql(2) }
    it { expect(moving.f).to eql(7) }
  end

  context "when goes right and down" do
    let(:moving) { subject.east.east.south }

    it { expect(moving.x).to eql(2) }
    it { expect(moving.y).to eql(1) }
    it { expect(moving.g).to eql(7) }
    it { expect(moving.h).to eql(1) }
    it { expect(moving.f).to eql(8) }
  end

  describe "#parent" do
    it { expect(subject.parent).to be_nil }
    it { expect(subject.east.parent).to eql(subject) }
  end

  describe "#==" do
    let(:another_step) { described_class.new(map, point, objective) }
    it { expect(subject == another_step).to eql(true) }
  end
end
