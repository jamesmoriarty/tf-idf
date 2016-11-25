# TFIDF [![Code Climate](https://codeclimate.com/github/jamesmoriarty/tf-idf/badges/gpa.svg)](https://codeclimate.com/github/jamesmoriarty/tf-idf) [![Test Coverage](https://codeclimate.com/github/jamesmoriarty/tf-idf/badges/coverage.svg)](https://codeclimate.com/github/jamesmoriarty/tf-idf)

tf–idf, short for term frequency–inverse document frequency, is a numerical statistic that is intended to reflect how important a word is to a document in a collection or corpus.[1]:8 It is often used as a weighting factor in information retrieval and text mining. The tf-idf value increases proportionally to the number of times a word appears in the document, but is offset by the frequency of the word in the corpus, which helps to adjust for the fact that some words appear more frequently in general.

http://en.wikipedia.org/wiki/Tf%E2%80%93idf

## Example Web App

https://james-moriarty-tf-idf.herokuapp.com/corpuses

![Screenshot](https://raw.githubusercontent.com/jamesmoriarty/tf-idf/master/app/public/images/Screen%20Shot%202014-12-23%20at%2012.08.00%20am.png)

```
cd app
bundle
rackup
open http://localhost:9292/corpuses
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tfidf', :github => 'jamesmoriarty/tf-idf'
```

And then execute:

    $ bundle


## Contributing

1. Fork it ( https://github.com/[my-github-username]/tf-idf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
