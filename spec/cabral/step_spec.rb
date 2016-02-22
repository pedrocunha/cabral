require "spec_helper"
require "cabral/step"

RSpec.describe Cabral::Step do
  let(:map) do
    [
      [0,1],
      [1,1]
    ]
  end

  subject { described_class.new(map, 0, 0) }

  it "returns 0 movement cost" do
    expect(subject.g).to eql(0)
  end

  context "when it moves to east" do
    let(:east) { subject.east }

    it { expect(east.x).to eql(1) }
    it { expect(east.y).to eql(0) }
    it { expect(east.g).to eql(1) }
  end

  context "when cost of movement is expensive" do
    let(:map) do
      [
        [0,5],
        [1,1]
      ]
    end
    let(:east) { subject.east }

    it { expect(east.x).to eql(1) }
    it { expect(east.y).to eql(0) }
    it { expect(east.g).to eql(5) }
  end

  context "when accumulates cost of movement" do
    let(:map) do
      [
        [0,5,10],
        [1,1,1]
      ]
    end
    let(:east) { subject.east.east }

    it { expect(east.x).to eql(2) }
    it { expect(east.y).to eql(0) }
    it { expect(east.g).to eql(15) }
  end

  context "when accumulates cost of movement between different directions" do
    let(:map) do
      [
        [0,5,10],
        [1,1,2]
      ]
    end
    let(:east) { subject.east.east.south }

    it { expect(east.x).to eql(2) }
    it { expect(east.y).to eql(1) }
    it { expect(east.g).to eql(17) }
  end
end
