require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate.range_or_value' do
  subject { Algebra::Restriction::Predicate.range_or_value(@value, @method) }

  describe 'with an Attribute' do
    before do
      @attribute = Attribute::Integer.new(:id, :size => 1..10)
      @value     = @attribute
      @method    = :last
    end

    it 'should execute the method on attribute range' do
      should == 10
    end
  end

  describe 'with a value' do
    before do
      @value  = 5
      @method = :last
    end

    it 'should execute the method on attribute range' do
      should == 5
    end
  end
end
