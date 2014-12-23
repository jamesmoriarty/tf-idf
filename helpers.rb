module Helpers
  def seed!
    corpus = TFIDF::Corpus.new

    Dir["./fixtures/*"].map(&IO.method(:read)).each do |text|
      corpus.documents << TFIDF::Document.new(text.downcase.split(/[^\w]/), text)
    end

    CorpusRepository.save(corpus)
  end

  def tfidf(document, corpus)
    document.term_frequencies.keys.map do |term|
      {
        term:  term,
        tf:    document.tf(term),
        idf:   corpus.idf(term),
        tfidf: corpus.tfidf(term, document)

      }
    end.sort_by { |hash| hash[:tfidf] }.reverse
  end

  def scores(tfidf)
    Hash[tfidf.map { |hash| [hash[:term], hash[:tfidf]] }]
  end

  def sentences(document, scores)
    document.text.split(/[\?.\-\;\/\,\\\>\<]|[^\d]:[^\d]/).map do |sentence|
      {
        score: sentence.downcase.split(/[^\w]/).map { |word| scores[word] || 0 }.inject(&:+),
        text:  sentence
      }
    end.sort_by { |hash| hash[:score] || 0 }.reverse
  end
end
