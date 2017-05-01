module Perseus
  CTS_PFX = "http://www.perseus.tufts.edu/hopper/CTS?request="
  DATA_DIR = Pathname.new(__FILE__).join("../../../data")
  CTS_XML_FILE = "#{DATA_DIR}/perseus-index.xml"
  CTS_BY_GROUP_JSON_FILE = "#{DATA_DIR}/perseus-index-by-group.json"
  ALL_EDITIONS_JSON = "#{DATA_DIR}/perseus-index-by-edition.json"
end
