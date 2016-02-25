require 'spec_helper'
require 'cabral/map'

RSpec.describe Cabral::Map do
  subject { described_class.new(map, origin, target) }

  context "scenario 1" do
    let(:map) do
      [
        [ 1 , 1 , 1 ],
        [ 1 , 1 , 1 ],
        [ 1 , 1 , 1 ]
      ]
    end

    let(:origin) { [0,0] }
    let(:target) { [2,0] }

    it "returns the path" do
      expect(subject.resolve).to eql([[0,0],[1,0],[2,0]])
    end
  end

  context "scenario 2" do
    let(:map) do
      [
        [ 1 , 1 , 1 ],
        [ 1 , 1 , 1 ],
        [ 1 , 1 , 1 ]
      ]
    end

    let(:origin) { [0,0] }
    let(:target) { [0,2] }

    it "returns the path" do
      expect(subject.resolve).to eql([[0,0],[0,1],[0,2]])
    end
  end

  context "scenario 3" do
    let(:map) do
      [
        [ 1 ,nil, 1 ],
        [ 1 ,nil, 1 ],
        [ 1 , 1 , 1 ]
      ]
    end

    let(:origin) { [0,0] }
    let(:target) { [2,0] }

    it "returns the path" do
      expect(subject.resolve).to eql(
        [
          [0,0],
          [0,1],
          [0,2],
          [1,2],
          [2,2],
          [2,1],
          [2,0]
        ]
      )
    end
  end

  context "scenario 4" do
    let(:map) do
      [
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ],
        [ 1 , 1 , 1 ,nil, 1 , 1 , 1 ],
        [ 1 , 1 , 1 ,nil, 1 , 1 , 1 ],
        [ 1 , 1 , 1 ,nil, 1 , 1 , 1 ],
        [ 1 ,nil, 1 ,nil, 1 , 1 , 1 ],
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ]
      ]
    end

    let(:origin) { [1,3] }
    let(:target) { [5,4] }

    it "returns the path" do
      expect(subject.resolve).to eql(
        [[1, 3], [2, 3], [2, 4], [2, 5], [3, 5], [4, 5], [5, 5], [5, 4]]
      )
    end
  end

  context "scenario 5" do
    let(:map) do
      [
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ],
        [ 1 , 1 , 1 ,nil, 1 , 1 , 1 ],
        [ 1 , 1 , 1 ,nil, 1 , 1 , 1 ],
        [ 1 , 1 , 1 ,nil, 1 , 1 , 1 ],
        [ 1 ,nil, 1 ,nil,nil,nil,nil],
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ]
      ]
    end

    let(:origin) { [1,3] }
    let(:target) { [5,3] }

    it "returns the path" do
      expect(subject.resolve).to eql(
        [[1, 3], [2, 3], [2, 2], [2, 1], [2, 0], [3, 0], [4, 0], [4, 1], [4, 2], [5, 2], [5, 3]]
      )
    end
  end

  context "scenario 6" do
    let(:map) do
      [
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ],
        [ 1 , 1 , 1 ,nil,nil,nil,nil],
        [ 1 , 1 , 1 ,nil, 1 , 1 , 1 ],
        [ 1 , 1 , 1 ,nil, 1 , 1 , 1 ],
        [ 1 ,nil, 1 ,nil,nil,nil,nil],
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ]
      ]
    end

    let(:origin) { [1,3] }
    let(:target) { [5,3] }

    it "returns nil as there is no path" do
      expect(subject.resolve).to be_nil
    end
  end

  context "scenario 6 with cost of movement" do
    let(:map) do
      [
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ],
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ],
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ],
        [ 1 , 1 ,20 , 1 , 1 , 1 , 1 ],
        [ 1 , 1,  5 , 1 , 1 , 1 , 1 ],
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ]
      ]
    end

    let(:origin) { [1,3] }
    let(:target) { [3,3] }

    it "returns the less cost path" do
      expect(subject.resolve).to eql(
        [[1, 3], [1, 2], [2, 2], [3, 2], [3, 3]]
      )
    end
  end

  context "scenario 7 with cost of movement" do
    let(:map) do
      [
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ],
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ],
        [ 1 , 5 , 5 , 5 , 1 , 1 , 1 ],
        [ 1 , 1 ,15 , 1 , 1 , 1 , 1 ],
        [ 1 , 5,  5 , 5 , 1 , 1 , 1 ],
        [ 1 , 1 , 1 , 1 , 1 , 1 , 1 ]
      ]
    end

    let(:origin) { [1,3] }
    let(:target) { [3,3] }

    it "returns the less cost path" do
      expect(subject.resolve).to eql(
        [[1, 3], [0, 3], [0, 2], [0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [4, 2], [4, 3], [3, 3]]
      )
    end
  end

  context "scenario 8 with cost of movement" do
    let(:map) do
      [
        [ 5 ,  5 , 5 ],
        [ 1 , 15 , 1 ],
        [ 5 ,  5 , 5 ]
      ]
    end

    let(:origin) { [0,1] }
    let(:target) { [2,1] }

    it "returns the less cost path" do
      expect(subject.resolve).to eql(
        [[0, 1], [1, 1], [2, 1]]
      )
    end
  end
end
