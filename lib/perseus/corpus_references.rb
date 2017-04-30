require 'perseus/cts_element'
module Perseus
  class CorpusReferences < CTSElement
    def initialize urn
      @urn = "#{CTS_PFX}GetValidReff&urn=#{urn}"
    end
  end
end
