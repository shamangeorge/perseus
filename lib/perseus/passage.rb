require 'perseus/cts_element'
module Perseus
  class Passage < CTSElement
    def initialize urn
      @urn = "#{CTS_PFX}GetPassage&urn=#{urn}"
    end
  end
end
