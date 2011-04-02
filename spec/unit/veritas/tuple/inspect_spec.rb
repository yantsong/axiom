require 'spec_helper'

describe Tuple, '#inspect' do
  subject { object.inspect }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { described_class.new(header, [ 1 ])         }

  it { should be_kind_of(String) }

  it { should == '[1]' }
end
