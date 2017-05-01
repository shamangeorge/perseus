require 'perseus/index_xml'
module Perseus
  class NetworkIndexXML < IndexXML
    # Models the whole perseus text index
    def initialize
      puts "Reading from the network"
      @urn = "http://www.perseus.tufts.edu/hopper/CTS?request=GetCapabilities"
      download
    end

    def download
      File.write(CTS_XML_FILE, to_s)
    end
  end
end
