# TFIDF [![Code Climate](https://codeclimate.com/github/jamesmoriarty/tf-idf/badges/gpa.svg)](https://codeclimate.com/github/jamesmoriarty/tf-idf) [![Test Coverage](https://codeclimate.com/github/jamesmoriarty/tf-idf/badges/coverage.svg)](https://codeclimate.com/github/jamesmoriarty/tf-idf)

tf–idf, short for term frequency–inverse document frequency, is a numerical statistic that is intended to reflect how important a word is to a document in a collection or corpus.[1]:8 It is often used as a weighting factor in information retrieval and text mining. The tf-idf value increases proportionally to the number of times a word appears in the document, but is offset by the frequency of the word in the corpus, which helps to adjust for the fact that some words appear more frequently in general.

http://en.wikipedia.org/wiki/Tf%E2%80%93idf

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tfidf'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tf-idf

## Usage

```ruby
require "tfidf"

@stops = "a,able,about,across,after,all,almost,also,am,among,an,and,any,are,as,at,be,because,been,but,by,can,cannot,could,dear,did,do,does,either,else,ever,every,for,from,get,got,had,has,have,he,her,hers,him,his,how,however,i,if,in,into,is,it,its,just,least,let,like,likely,may,me,might,most,must,my,neither,no,nor,not,of,off,often,on,only,or,other,our,own,rather,said,say,says,she,should,since,so,some,than,that,the,their,them,then,there,these,they,this,tis,to,too,twas,us,wants,was,we,were,what,when,where,which,while,who,whom,why,will,with,would,yet,you,your".split(",")
@corpus = Corpus.new
Dir["./test/fixtures/*"].map { |path| IO.read(path) }.each do |text|
  document = Document.new(text.downcase.split(/[^a-z]/))
  @stops.each { |word| document.term_frequencies.delete(word) }
  @corpus.documents << document
end

document = @corpus.documents.first
terms    = document.term_frequencies.keys
results  = terms.map do |term|
  [
    '%10s' % term,
    '%.4f' % document.tf(term),
    '%.4f' % @corpus.idf(term),
    '%.4f' % @corpus.tfidf(term, document)
  ]
end.sort_by(&:last).reverse[0..10]
pp results
# =>
# [["properties", "2.6094", "3.6463", "9.5148"],
# ["   antonio", "2.0986", "4.0518", "8.5031"],
# ["      info", "2.3863", "2.7525", "6.5683"],
# ["    mailed", "1.6931", "3.7641", "6.3732"],
# ["     faxed", "1.6931", "3.7641", "6.3732"],
# ["       san", "2.0986", "3.0103", "6.3175"],
# ["     units", "1.6931", "3.5410", "5.9954"],
# ["  austintx", "2.3863", "2.2882", "5.4603"],
# ["    jsmith", "2.3863", "2.2882", "5.4603"],
# ["     three", "1.6931", "3.1355", "5.3089"],
# ["     smith", "2.3863", "1.9934", "4.7568"]]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tf-idf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
