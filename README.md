# perseus

[![pipeline
status](https://damos.fruitopology.net/agora/perseus/badges/master/pipeline.svg)](https://damos.fruitopology.net/agora/perseus/commits/master)

#### description
a ruby gem that provides various wrappers and cli utilities
around the open APIs provided by
[perseus](http://www.perseus.tufts.edu/hopper/).

#### currently supported APIS
* word queries similar to
  [this one](http://www.perseus.tufts.edu/hopper/xmlmorph?lang=greek&lookup=efhn)
* a ruby wrapper around the APIs provided
  [here](http://sites.tufts.edu/perseusupdates/beta-features/perseus-cts-api/)

## installation

Add this line to your application's Gemfile:

```ruby
gem 'perseus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install perseus

## usage

    $ perseus --help
    Usage: perseus [options]

    Specific options:
      --generate_json []           Generates the perseus indeces in json format choose fetch method (network -> download, save and index from network, local -> index from already downloaded xml file)
      --word WORD                  Search ancient greek or latin word
      --valid_refs URN             Get valid urn's to query passage content
      --passage URN                Get passage content for given urn
      --title TITLE                Search by title
      --author GROUPNAME/AUTHOR    Search by groupname/author
      -v, --[no-]verbose           Run verbosely

    Common options:
      -h, --help                   Show this message
      --version                    Show version

    $ homer --help
      options:
        -b, --book - specify the book
        -l, --line - specify the line you want to fetch
        --books - specify the books (ex. --books=[1,4,5)
        --lines - specify the lines you want to fetch (ex. --lines=[4,25,65]

## screenshots

![by_author](https://raw.githubusercontent.com/shamangeorge/perseus/master/examples/by_author.png)
![by_title](https://raw.githubusercontent.com/shamangeorge/perseus/master/examples/by_title.png)
![by_word](https://raw.githubusercontent.com/shamangeorge/perseus/master/examples/by_word.png)


## development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shamangeorge/perseus.

## license

check `LICENCE.txt`
