require 'perseus/index_xml'
module Perseus
  class FileIndexXML < IndexXML
    def initialize
      puts "Reading from locally saved xml"
      @urn = "/home/pikos/perseus/data/perseus-index.xml"
    end
    def to_s
      @to_s ||= File.read(@urn)
    end
  end
end
