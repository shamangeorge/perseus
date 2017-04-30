require 'awesome_print'
require 'perseus/corpus_hash'
require 'perseus/cts_element'
module Perseus
  class IndexXML < CTSElement
    attr_reader :corpus_by_groupname, :corpus_by_edition
    def by_groupname
      @corpus_by_groupname ||= generate_structure_by_group
    end
    def by_edition
      @corpus_by_edition ||= generate_structure_by_edition
    end

    def generate_structure_by_group
      to_h["TextInventory"]["textgroup"].map do |text|
        CorpusHash.new text
      end.map do |t|
        tmp_hash = CorpusHash.new
        t.work.each_with_index do |work, i|
          if work.kind_of?(Array)
            # This is a special kind of array and we need to make
            # it adhere to our protocol
            tmp_hash[work[0]] = work[1]
            #puts work.inspect
            #puts tmp_hash
            if t.work.size - 1 == i
              t.work = [tmp_hash]
              tmp_hash = CorpusHash.new
            end
          end
        end && t
      end
    end

    def generate_structure_by_edition
      new_corpus = []
      corpus_by_groupname.each do |t|
        groupname = t.groupname
        t.work.each_with_index do |work, i|
          begin
            # Check if we have many editions
            unless work["edition"].nil?
              if work.edition.kind_of?(Array)
                work.edition.each do |edition|
                  new_corpus.push(CorpusHash.new({
                    groupname: groupname,
                    language: work["xml:lang"],
                    type: "edition",
                  }).merge(edition))
                end
              else
                new_corpus.push(CorpusHash.new({
                  groupname: groupname,
                  language: work["xml:lang"],
                  type: "edition",
                }).merge(work.edition))
              end
            end
            # Check to see if we have translations
            unless work["translation"].nil?
              # Check if we have many translations
              if work.translation.kind_of?(Array)
                work.translation.each do |translation|
                  new_corpus.push(CorpusHash.new({
                    groupname: groupname,
                    language: translation["xml:lang"],
                    type: "edition",
                  }).merge(translation))
                end
              else
                new_corpus.push(CorpusHash.new({
                  groupname: groupname,
                  language: work.translation["xml:lang"],
                  type: "edition",
                }).merge(work.translation))
              end
            end
          rescue Exception => e
            puts "exception: #{e.message.red}"
            #puts "Stack trace: #{backtrace.map {|l| "  #{l}\n"}.join}"
            puts "We were working in group: #{groupname.cyan} with the following data point:".green
            puts work.inspect.yellow
          end
        end
      end
      new_corpus
    end

    def generate_json_indeces
      puts "Generating index by groupname"
      File.write("data/perseus-index-by-group.json", JSON.pretty_generate(by_groupname))
      puts "Generating index by edition"
      File.write("data/perseus-index-by-edition.json", JSON.pretty_generate(by_edition))
      puts "DONE".green
    end
  end
end
