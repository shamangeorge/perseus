require 'perseus/index_xml'
module Perseus
  class NetworkIndexXML < IndexXML
    # Models the whole perseus text index
    def initialize
      puts "Reading from the network"
      @urn = "http://www.perseus.tufts.edu/hopper/CTS?request=GetCapabilities"
    end

    def download
      File.write("data/perseus-index.xml", to_s)
    end
  end
end
