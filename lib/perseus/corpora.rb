require 'json'
require 'hashie'
require 'perseus/corpus_hash'

module Perseus
  class Corpora
    def initialize category
      @elements = JSON.parse(File.read("data/perseus-index-by-#{category}.json")).map do |e|
        Perseus::CorpusHash.new e
      end
      @elements.extend(Hashie::Extensions::DeepLocate)
    end
    def all
      @elements
    end
  end
end
