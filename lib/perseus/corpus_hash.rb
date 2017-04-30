require 'hashie'
module Perseus
  class CorpusHash < Hash
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::Coercion
    coerce_value Hash, CorpusHash
    def initialize(hash = {})
      super
      hash.each_pair do |k,v|
        if v.kind_of?(Array)
          self[k] = v.map { |v_i| CorpusHash.new(v_i) }
        elsif v.kind_of?(Hash)
          self[k] = CorpusHash.new v
        else
          self[k] = v
        end
      end
    end
  end
end
