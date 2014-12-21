# TFIDF [![Code Climate](https://codeclimate.com/github/jamesmoriarty/tf-idf/badges/gpa.svg)](https://codeclimate.com/github/jamesmoriarty/tf-idf) [![Test Coverage](https://codeclimate.com/github/jamesmoriarty/tf-idf/badges/coverage.svg)](https://codeclimate.com/github/jamesmoriarty/tf-idf)

tf–idf, short for term frequency–inverse document frequency, is a numerical statistic that is intended to reflect how important a word is to a document in a collection or corpus.[1]:8 It is often used as a weighting factor in information retrieval and text mining. The tf-idf value increases proportionally to the number of times a word appears in the document, but is offset by the frequency of the word in the corpus, which helps to adjust for the fact that some words appear more frequently in general.

http://en.wikipedia.org/wiki/Tf%E2%80%93idf

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tf-idf'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tf-idf

## Usage

```ruby
require "tfidf"

corpus = TFIDF::Corpus.new([
  TFIDF::Document.new("nothing overlaps".split(" ")),
  TFIDF::Document.new("something overlaps".split(" "))
])
corpus.idf("overlaps")
# => 0
corpus.idf("nothing")
# => 0.6931471805599453
corpus.idf("zoo")
# => 0
corpus.documents.last.term_frequencies.keys.map { |term| [term, c.tfidf(term)] }.sort_by(&:last)
# => [["overlaps", 0.0], ...
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tf-idf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
