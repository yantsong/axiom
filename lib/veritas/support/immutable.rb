module Veritas
  module Immutable
    def self.included(descendant)
      descendant.extend ModuleMethods if descendant.kind_of?(Module)
      descendant.extend ClassMethods  if descendant.kind_of?(Class)
      self
    end

    def dup
      self
    end

    module ModuleMethods
      def included(mod)
        Immutable.included(mod)
      end

      def memoize(*methods)
        include_memoize_methods
        methods.each do |method|
          memoized_method = "__memoized_#{method}"
          alias_private_method(memoized_method, method)
          create_memoize_method_for(memoized_method, method)
        end
        self
      end

    private

      def include_memoize_methods
        include MemoizeMethods unless include?(MemoizeMethods)
      end

      def alias_private_method(new_method, old_method)
        alias_method new_method, old_method
        private new_method
      end

      def create_memoize_method_for(memoized_method, method)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          #{method_visibility(method)}
          def #{method}
            @__memory['@#{method}'] ||= #{memoized_method}.freeze
          end
        RUBY
      end

      def method_visibility(method)
        if    private_method_defined?(method)   then 'private'
        elsif protected_method_defined?(method) then 'protected'
        else                                         'public'
        end
      end

    end # module ModuleMethods

    module ClassMethods
      def new(*args)
        super.freeze
      end

    end # module ClassMethods

    module MemoizeMethods
      def freeze
        @__memory = Memory.new unless frozen?
        super
      end

      def memoize(name, value)
        value = value.dup.freeze unless value.frozen?
        @__memory["@#{name}"] = value
        self
      end

    end # module MemoizeMethods

    class Memory
      extend Aliasable

      inheritable_alias(
        :[]  => :instance_variable_get,
        :[]= => :instance_variable_set
      )
    end # class Memory
  end # module Immutable
end # module Veritas