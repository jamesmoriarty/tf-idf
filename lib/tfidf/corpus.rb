require "forwardable"

module TFIDF
  class Corpus
    extend Forwardable

    attr_accessor :documents

    def_delegators :documents, :size, :add, :delete

    def initialize(documents = [])
      self.documents = documents
    end

    # \mathrm{idf}(t, D) =  \log \frac{N}{|\{d \in D: t \in d\}|}
    def idf(term)
      denominator = documents.select { |document| document.tf(term, :boolean) }.size
      return 0 if denominator.zero?
      Math.log(documents.size / denominator.to_f)
    end

    # \mathrm{tfidf}(t,d,D) = \mathrm{tf}(t,d) \times \mathrm{idf}(t, D)
    def tfidf(term, document, strategy = :logarithmic)
      document.tf(term, strategy) * idf(term)
    end
  end
end
