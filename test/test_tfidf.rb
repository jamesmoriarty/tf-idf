require "test_helper"

module TFIDF
  class TestTFIDF < Minitest::Test
    describe "TFIDF::Corpus" do
      before do
        @corpus = Corpus.new([Document.new("nothing overlaps".split(" ")), Document.new("something overlaps".split(" "))])
      end

      it "#size" do
        assert_equal 2, @corpus.size
      end

      it "#idf" do
        assert_equal 0, @corpus.idf("overlaps")
        assert_equal 0.6931471805599453, @corpus.idf("nothing")
        assert_equal 0, @corpus.idf("zoo")
      end
    end

    describe "TFIDF::Document" do
      before do
        @document = Document.new("This is is is a short test".split(" "))
      end

      it "#initialize" do
        assert_equal 3, @document["is"]
      end

      it "#size" do
        assert_equal 5, @document.size
      end

      it "#tf - boolean" do
        assert_equal true,  @document.tf("is", :boolean)
        assert_equal true,  @document.tf("short", :boolean)
        assert_equal false, @document.tf("zoo", :boolean)
      end

      it "#tf - logarithmic" do
        assert_equal 2.09861228866811, @document.tf("is")
        assert_equal 2.09861228866811, @document.tf("is", :logarithmic)
        assert_equal 0.0,                @document.tf("zoo", :logarithmic)
      end

      it "#tf - augmented" do
        assert_equal 1.0, @document.tf("is", :augmented)
        assert_equal 0.5, @document.tf("zoo", :augmented)
      end
    end
  end
end
