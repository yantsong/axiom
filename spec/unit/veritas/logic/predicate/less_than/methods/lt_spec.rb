require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate::LessThan::Methods, '#lt' do
  subject { object.lt(other) }

  let(:described_class) { LessThanMethodsSpecs::Object }
  let(:other)           { 1                            }
  let(:object)          { described_class.new          }

  it { should be_kind_of(Logic::Predicate::LessThan) }
end
