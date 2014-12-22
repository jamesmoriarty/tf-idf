require "forwardable"

module TFIDF
  class Document
    extend Forwardable

    attr_accessor :text, :term_frequencies

    def_delegators :term_frequencies, :size, :"[]", :sort

    def initialize(enumerable, text = nil)
      self.text             = text
      self.term_frequencies = Hash.new(0)

      enumerable.each do |term|
        term_frequencies.merge!(term => 1) { |term, count, increment| count + increment }
      end
    end

    def tf(term, strategy = :logarithmic)
      case strategy
      when :boolean
        self[term] >= 1
      when :logarithmic
        self[term] > 0 ? 1 + Math.log(self[term]) : 0
      # \mathrm{tf}(t,d) = 0.5 + \frac{0.5 \times \mathrm{f}(t, d)}{\max\{\mathrm{f}(w, d):w \in d\}}
      when :augmented
        0.5 + (0.5 * self[term]) / term_frequencies.values.max
      end
    end
  end
end
