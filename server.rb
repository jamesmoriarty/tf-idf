require 'bundler/setup'
require 'slim'
require 'sinatra/base'
require 'tfidf'
require './corpus_repository'

class Server < Sinatra::Base
  set :sessions,        true
  set :method_override, true

  get '/' do
    redirect '/corpuses'
  end

  get '/corpuses' do
    @corpuses = CorpusRepository.all

    slim :index
  end

  post '/corpuses' do
    @corpus = CorpusRepository.save(TFIDF::Corpus.new)

    redirect '/corpuses'
  end

  get '/corpuses/:id' do
    @corpus = CorpusRepository.find(params[:id].to_i)

    slim :show
  end

  delete '/corpuses/:id' do
    @corpus = CorpusRepository.destroy(params[:id].to_i)

    redirect '/corpuses'
  end

  post '/corpuses/:corpus_id/documents' do
    @corpus = CorpusRepository.find(params[:corpus_id].to_i)
    text = params[:document][:text]
    @corpus.documents << TFIDF::Document.new(text.downcase.split(/[^\w]/), text)
    CorpusRepository.save(@corpus)
    redirect "/corpuses/#{params[:corpus_id]}"
  end

  get '/corpuses/:corpus_id/documents/:id' do
    @corpus   = CorpusRepository.find(params[:corpus_id].to_i)
    @document = @corpus.documents[params[:id].to_i]
    @tfidf    = @document.term_frequencies.keys.map do |term|
      {
        term:  term,
        tf:    @document.tf(term),
        idf:   @corpus.idf(term),
        tfidf: @corpus.tfidf(term, @document)

      }
    end.sort_by { |hash| hash[:tfidf] }.reverse
    @scores = Hash[@tfidf.map { |hash| [hash[:term], hash[:tfidf]] }]
    @sentences = @document.text.split(/[\?.\-\;\/\,\\\>\<]|[^\d]:[^\d]/).map do |sentence|
      {
        score: sentence.downcase.split(/[^\w]/).map { |word| @scores[word] || 0 }.inject(&:+),
        text:  sentence
      }
    end.sort_by { |hash| hash[:score] || 0 }.reverse

    slim :"documents/show"
  end

  delete '/corpuses/:corpus_id/documents/:id' do
    @corpus   = CorpusRepository.find(params[:corpus_id].to_i)
    @document = @corpus.documents[params[:id].to_i]
    @corpus.documents.delete(@document)
    redirect "/corpuses/#{params[:corpus_id]}"
  end

  if CorpusRepository.all.compact.size.zero?
    corpus = TFIDF::Corpus.new

    Dir["./fixtures/*"].map(&IO.method(:read)).each do |text|
      corpus.documents << TFIDF::Document.new(text.downcase.split(/[^\w]/), text)
    end

    CorpusRepository.save(corpus)
  end

  run! if app_file == $0
end
