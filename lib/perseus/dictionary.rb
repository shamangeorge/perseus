require 'perseus/cts_element'
module Perseus
  class Dictionary < CTSElement
    def initialize word
      @urn = "http://www.perseus.tufts.edu/hopper/xmlmorph?lang=greek&lookup=#{word}"
    end
  end
end
