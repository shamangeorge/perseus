require 'json'
require 'hashie'
require 'perseus/corpus_hash'

module Perseus
  class Corpora
    def initialize
      @elements = JSON.parse(File.read(Perseus::ALL_EDITIONS_JSON)).map do |e|
        Perseus::CorpusHash.new e
      end
      @elements.extend(Hashie::Extensions::DeepLocate)
    end
    def all
      @elements
    end
  end
end
