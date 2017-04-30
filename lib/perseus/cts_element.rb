require 'json'
require 'active_support'
require 'active_support/core_ext'
require 'net/http'
require 'uri'
module Perseus
  class CTSElement
    attr_reader :to_s, :to_h, :to_json
    def to_s
      @to_s ||= Net::HTTP.get(URI.parse(@urn))
    end
    def to_h
      @to_h ||= Hash.from_xml(to_s)
    end
    def to_json
      @to_json ||= to_h.to_json
    end
  end
end
