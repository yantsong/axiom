require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::BinaryConnective#complement' do
  subject { connective.complement }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:left)       { Logic::Predicate::Equality.new(header[:id], 1)                }
  let(:right)      { Logic::Predicate::Equality.new(header[:id], 2)                }
  let(:connective) { BinaryConnectiveSpecs::Complement.new(left, right)            }

  it 'complements the connective' do
    should eql(Logic::Connective::Complement.new(connective))
  end

  it 'is reversible' do
    subject.complement.should eql(connective)
  end

  it_should_behave_like 'an idempotent method'
end
