module PredicateComparableSpecs
  class Object
    include Immutable
    include Veritas::Logic::Predicate::Comparable

    attr_reader :left, :right

    def self.operation
      :==
    end

    def self.complement
      self
    end

    def initialize(left, right)
      @left, @right = left, right
    end

  end # class Object
end # module PredicateComparableSpecs
