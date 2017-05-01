require 'perseus/index_xml'
module Perseus
  class FileIndexXML < IndexXML
    def initialize
      puts "Reading from locally saved xml"
      @urn = CTS_XML_FILE
    end
    def to_s
      @to_s ||= File.read(@urn)
    end
  end
end
