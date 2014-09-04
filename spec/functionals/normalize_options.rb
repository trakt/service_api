require 'spec_helper'

describe NormalizeOptions do
  describe 'hash options' do
    it 'return hash with mapped keys' do
      expect(NormalizeOptions.new({ e1: :o1, e2: :o2 }, e1: 'test1', e2: 'test2').parse).to eq(o1: 'test1', o2: 'test2')
    end

    it 'return original hash' do
      expect(NormalizeOptions.new([:e1, :e2], e1: 'test1', e2: 'test2').parse).to eq(e1: 'test1', e2: 'test2')
    end
  end

  describe 'normal options' do
    it 'return hash with mapped keys' do
      expect(NormalizeOptions.new({ e1: :o1, e2: :o2 }, 'test1', 'test2').parse).to eq(o1: 'test1', o2: 'test2')
    end

    it 'return correct hash' do
      expect(NormalizeOptions.new([:e1, :e2], 'test1', 'test2').parse).to eq(e1: 'test1', e2: 'test2')
    end
  end
end