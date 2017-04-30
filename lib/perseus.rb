require "perseus/version"
require 'json'
require 'active_support'
require 'active_support/core_ext'
require 'net/http'
require 'uri'

module Perseus
  CTS_PFX = "http://www.perseus.tufts.edu/hopper/CTS?request="
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

  class CTSElement
    def initialize
    end
    def to_s
      Net::HTTP.get(URI.parse(@urn))
    end
    def to_h
      Hash.from_xml(to_s)
    end
    def to_json
      #Hash.from_xml(to_s).to_json
      to_h.to_json
    end
  end

  class Passage < CTSElement
    def initialize urn, section
      @urn = "#{CTS_PFX}GetPassage&urn=#{urn}:#{section}"
    end
  end

  class CorpusReferences < CTSElement
    def initialize urn
      @urn = "#{CTS_PFX}GetValidReff&urn=#{urn}"
    end
  end

  class Index < CTSElement
    attr_reader :corpus
    # Models the whole perseus text index
    def initialize
      puts "Reading from the network"
      @urn = "http://www.perseus.tufts.edu/hopper/CTS?request=GetCapabilities"
    end

    def corpus
      @corpus ||= generate_structure
    end

    def generate_structure
      to_h["TextInventory"]["textgroup"].map do |text|
        CorpusHash.new text
      end.map do |t|
        tmp_hash = CorpusHash.new
        t.work.each_with_index do |work, i|
          if work.kind_of?(Array)
            # This is a special kind of array and we need to make
            # it adhere to our protocol
            tmp_hash[work[0]] = work[1]
            #puts work.inspect
            #puts tmp_hash
            if t.work.size - 1 == i
              t.work = [tmp_hash]
              tmp_hash = CorpusHash.new
            end
          end
        end && t
      end
    end
  end

  class FileIndex < Index
    # Models the whole perseus text index
    def initialize
      puts "Reading from locally saved xml"
      @urn = "/home/pikos/perseus/data/perseus-index.xml"
    end

    def to_s
      File.read(@urn)
    end
  end

  class Dictionary < CTSElement
    def initialize word
      @urn = "http://www.perseus.tufts.edu/hopper/xmlmorph?lang=greek&lookup=#{word}"
    end
  end
end
