module Rbslack
  module Extension
    module HashExt
      refine Hash do
        # written with reference to activesupport/lib/active_support/core_ext/hash/keys.rb
        def transform_keys
          result = {}
          each_key do |key|
            result[yield(key)] = self[key]
          end
          result
        end unless method_defined?(:transform_keys)

        def transform_keys!
          keys.each do |key|
            self[yield(key)] = delete(key)
          end
          self
        end unless method_defined?(:transform_keys!)

        def stringify_keys
          transform_keys(:to_s)
        end unless method_defined?(:stringify_keys)

        def stringify_keys!
          transform_keys!(:to_s)
        end unless method_defined?(:stringify_keys!)

        def symbolize_keys
          transform_keys { |key| key.to_sym rescue key }
        end unless method_defined?(:symbolize_keys)

        def symbolize_keys!
          transform_keys! { |key| key.to_sym rescue key }
        end unless method_defined?(:symbolize_keys!)
      end
    end
  end
end
