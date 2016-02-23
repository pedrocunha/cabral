require "spec_helper"
require "cabral/point"

RSpec.describe Cabral::Point do
  let(:point) { described_class.new(1,1) }

  describe "#north" do
    subject { point.north }
    it { expect(subject.x).to eql(1) }
    it { expect(subject.y).to eql(0) }
  end

  describe "#east" do
    subject { point.east }
    it { expect(subject.x).to eql(2) }
    it { expect(subject.y).to eql(1) }
  end

  describe "#south" do
    subject { point.south }
    it { expect(subject.x).to eql(1) }
    it { expect(subject.y).to eql(2) }
  end

  describe "#west" do
    subject { point.west }
    it { expect(subject.x).to eql(0) }
    it { expect(subject.y).to eql(1) }
  end
end

