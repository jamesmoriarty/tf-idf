require "test_helper"

module TFIDF
  class TestTFIDF < Minitest::Test
    describe "Example" do
      before do
        @stops = "a,able,about,across,after,all,almost,also,am,among,an,and,any,are,as,at,be,because,been,but,by,can,cannot,could,dear,did,do,does,either,else,ever,every,for,from,get,got,had,has,have,he,her,hers,him,his,how,however,i,if,in,into,is,it,its,just,least,let,like,likely,may,me,might,most,must,my,neither,no,nor,not,of,off,often,on,only,or,other,our,own,rather,said,say,says,she,should,since,so,some,than,that,the,their,them,then,there,these,they,this,tis,to,too,twas,us,wants,was,we,were,what,when,where,which,while,who,whom,why,will,with,would,yet,you,your"
        @stops = @stops.split(",")
        @corpus = Corpus.new
        Dir["./test/fixtures/*"].map { |path| IO.read(path) }.each do |text|
          document = Document.new(text.downcase.split(/[^a-z]/))
          @stops.each { |word| document.term_frequencies.delete(word) }
          @corpus.documents << document
        end
      end

      it "#tfidf" do
        document = @corpus.documents.last
        terms    = document.term_frequencies.keys
        results  = terms.map { |term| [term, @corpus.tfidf(term, document)] }.sort_by(&:last)
        pp results
      end
    end
  end
end
