require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:order)    { Relation.new(header, [ [ 1 ] ].each).order }
  let(:relation) { order.rename({}).take(1)                   }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Relation::Operation::Limit)
  end

  it { should be_kind_of(Relation::Operation::Limit) }

  its(:operand) { should equal(order) }

  its(:limit) { should == 1 }
end
