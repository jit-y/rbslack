require 'spec_helper'
class TestClass
  using Rbslack::Extension::HashExt
  attr_reader :hash
  def initialize(hash)
    @hash = hash
  end

  def transform_keys
    hash.transform_keys(&:to_s)
  end

  def transform_keys!
    hash.transform_keys!(&:to_s)
  end

  def stringify_keys
    hash.stringify_keys
  end

  def stringify_keys!
    hash.stringify_keys!
  end

  def symbolize_keys
    hash.symbolize_keys
  end

  def symbolize_keys!
    hash.symbolize_keys!
  end
end

describe Rbslack::Extension::HashExt do
  let(:instance) { TestClass.new(hash) }
  describe '#transform_keys' do
    let!(:hash) { { dummy: 'dummy' } }
    subject { instance.transform_keys }
    it 'transforms keys of Hash to String non-destructively' do
      expect(subject.keys.first).to be_an_instance_of(String)
      expect(subject.keys.first).to eq 'dummy'
      expect(instance.hash.keys.first).to be_an_instance_of(Symbol)
      expect(instance.hash.keys.first).to eq :dummy
    end
  end

  describe '#transform_keys!' do
    let!(:hash) { { dummy: 'dummy' } }
    subject { instance.transform_keys! }
    it 'transforms keys of Hash to String destructively' do
      expect(subject.keys.first).to be_an_instance_of(String)
      expect(subject.keys.first).to eq 'dummy'
      expect(instance.hash.keys.first).to be_an_instance_of(String)
      expect(instance.hash.keys.first).to eq 'dummy'
    end
  end

  describe '#stringify_keys' do
    let!(:hash) { { dummy: 'dummy' } }
    subject { instance.stringify_keys }
    it 'transforms keys of Hash to String non-destructively' do
      expect(subject.keys.first).to be_an_instance_of(String)
      expect(subject.keys.first).to eq 'dummy'
      expect(instance.hash.keys.first).to be_an_instance_of(Symbol)
      expect(instance.hash.keys.first).to eq :dummy
    end
  end

  describe '#stringify_keys!' do
    let!(:hash) { { dummy: 'dummy' } }
    subject { instance.stringify_keys! }
    it 'transforms keys of Hash to String destructively' do
      expect(subject.keys.first).to be_an_instance_of(String)
      expect(subject.keys.first).to eq 'dummy'
      expect(instance.hash.keys.first).to be_an_instance_of(String)
      expect(instance.hash.keys.first).to eq 'dummy'
    end
  end

  describe '#symbolize_keys' do
    let!(:hash) { { 'dummy' => 'dummy' } }
    subject { instance.symbolize_keys }
    context 'transformmable key' do
      it 'transforms keys of Hash to String non-destructively' do
        expect(subject.keys.first).to be_an_instance_of(Symbol)
        expect(subject.keys.first).to eq :dummy
        expect(instance.hash.keys.first).to be_an_instance_of(String)
        expect(instance.hash.keys.first).to eq 'dummy'
      end
    end
    context 'containing untransformable keys' do
      let!(:struct) { Struct.new(:dummy) }
      let!(:hash) { { struct => 'dummy' } }
      it 'does not transform untransformable key' do
        expect(subject.keys.first).to be_an_instance_of(Class)
        expect(subject.keys.first).to eq struct
      end
    end
  end

  describe '#symbolize_keys!' do
    subject { instance.symbolize_keys! }
    context 'transformmable key' do
      let!(:hash) { { 'dummy' => 'dummy' } }
      it 'transforms keys of Hash to String destructively' do
        expect(subject.keys.first).to be_an_instance_of(Symbol)
        expect(subject.keys.first).to eq :dummy
        expect(instance.hash.keys.first).to be_an_instance_of(Symbol)
        expect(instance.hash.keys.first).to eq :dummy
      end
    end
    context 'containing untransformable keys' do
      let!(:struct) { Struct.new(:dummy) }
      let!(:hash) { { struct => 'dummy' } }
      it 'does not transform untransformable key' do
        expect(subject.keys.first).to be_an_instance_of(Class)
        expect(subject.keys.first).to eq struct
      end
    end
  end
end
