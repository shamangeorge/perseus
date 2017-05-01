module Perseus
  def self.print_editions editions
    editions.each do |edition|
      print_corpus_info edition.groupname, edition.type, edition.label, edition.urn, edition.language.green, edition.description
    end
  end
  def self.print_corpus texts
    texts.each do |t|
      groupname = t.groupname
      t.work.each_with_index do |work, i|
        begin
          # Check if we have many editions
          unless work["edition"].nil?
            language = work["xml:lang"]
            if work.edition.kind_of?(Array)
              work.edition.each do |edition|
                title = edition.label
                urn = edition.urn
                desc = edition.description
                print_corpus_info groupname, "edition", title, urn, language.green, desc
              end
            else
              title = work.title
              urn = work.edition.urn
              desc = work.edition.description
              print_corpus_info groupname, "edition", title, urn, language.green
            end
          end
          # Check to see if we have translations
          unless work["translation"].nil?
            # Check if we have many translations
            if work.translation.kind_of?(Array)
              work.translation.each do |translation|
                title = translation.label
                urn = translation.urn
                language = translation["xml:lang"]
                print_corpus_info groupname, "translation", title, urn, language.redish
              end
            else
              title = work.title
              urn = work.translation.urn
              language = work.translation["xml:lang"]
              print_corpus_info groupname, "translation", title, urn, language.redish
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
  end

  def self.print_corpus_info groupname, type, title, urn, language, description = nil
    puts "#{groupname} - #{title.purple}: #{urn.yellow}, #{type}: #{language}"
    unless description.nil?
      puts description.cyan
    end
  end
end
