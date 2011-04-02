require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::MaterializedOperand, '#optimize' do
  subject { object.optimize }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).project([ :id ]) }
  let(:object)   { described_class.new(relation)                                       }

  it { should be_kind_of(Relation::Materialized) }

  its(:header) { should equal(relation.header) }

  it { should == [ [ 1 ] ] }
end
