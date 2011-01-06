require 'spec_helper'

describe 'Veritas::Algebra::Projection#eql?' do
  subject { object.eql?(other) }

  let(:klass)      { Algebra::Projection                                         }
  let(:body)       { [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb'] ] }
  let(:operand)    { Relation.new([ [ :id, Integer ], [ :name, String ] ], body) }
  let(:attributes) { [ :id ]                                                     }
  let(:object)     { klass.new(operand, attributes)                              }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(klass).new(operand, attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different operand' do
    let(:other_operand)    { Relation.new([ [ :id, Integer ] ], [ [ 3 ] ]) }
    let(:other_attributes) { attributes                                    }
    let(:other)            { klass.new(other_operand, other_attributes)    }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having different attributes' do
    let(:other_operand)    { operand                                    }
    let(:other_attributes) { []                                         }
    let(:other)            { klass.new(other_operand, other_attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end