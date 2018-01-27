#!/usr/bin/env ruby

require "perseus"
require "elasticsearch"

host = ENV['ES_HOST'] || "localhost"
port = ENV['ES_PORT'] || 9200
ES_CONFIG = [{
    host: host,
      port: port
}].freeze
@es_client = Elasticsearch::Client.new hosts: ES_CONFIG
@_index = "perseus-cts-by-edition"
@_type = "edition"

DESTRUCTIVE = true
def extract_field field, string
  match = "Perseus:bib:#{field},"
  f = string[/#{match}\d+/]
  unless f.nil?
    f.gsub(match, "")
  end
end

file = Perseus::ALL_EDITIONS_JSON
json = JSON.parse(File.read(file))
json.each do |doc|
  _id = doc["urn"]
  doc["collection"] = doc["memberof"]["collection"].gsub("Perseus:collection:", "")
  doc["project"] = doc["projid"]
  doc["group"] = doc["groupname"]
  # extract some info from the description like oclc and isbn codes if they exist
  description = doc["description"]
  isbn = extract_field("isbn", description)
  oclc = extract_field("oclc", description)
  doc["isbn"] = isbn unless isbn.nil?
  doc["oclc"] = oclc unless oclc.nil?
  doc["edition"] = description.gsub(/Perseus:bib:isbn,\d+, /, "").gsub(/Perseus:bib:oclc,\d+, /, "")
  if DESTRUCTIVE
    doc.delete("online")
    doc.delete("urn")
    doc.delete("memberof")
    doc.delete("projid")
    doc.delete("groupname")
    doc.delete("xml:lang")
    doc.delete("description")
  end
  begin
    @es_client.get(index: @_index, type:@_type, id:_id)
    puts "Updating existing document: #{doc.inspect}"
    @es_client.update(index: @_index, type:@_type, id:_id, body: { doc: doc })
  rescue Elasticsearch::Transport::Transport::Errors::NotFound => not_found
    #puts not_found.message
    puts "Creating new document: #{doc.inspect}"
    @es_client.create(index: @_index, type:@_type, id:_id, body: doc)
    puts "Document indexed"
  end
end
