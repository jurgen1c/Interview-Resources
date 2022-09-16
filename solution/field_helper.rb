module FieldHelper
  # Code that should be added by candidate below
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def create_helpers(hash, prefix: nil)
      hash_fields = hash.keys
      hash_fields.each do |field_key|
        send(:define_method, build_prefix(prefix, field_key)) do |*args, &block|
          return block.call(hash[field_key], *args) if block
          hash[field_key]
        end
        if hash[field_key].is_a?(Array)
          hash[field_key].each_with_index do |arr_hash, i|
            next unless arr_hash.is_a?(Hash)
            create_helpers(arr_hash, prefix: build_prefix(prefix, field_key, i))
          end
        end
        if hash[field_key].is_a?(Hash)
          create_helpers(hash[field_key], prefix: build_prefix(prefix, field_key))
        end
      end
    end

    def build_prefix(*args)
      args.compact.join('_')
    end
  end
end