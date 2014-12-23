require 'bundler/setup'
require 'slim'
require 'sinatra/base'
require 'tfidf'
require './corpus_repository'
require './helpers'

class Server < Sinatra::Base
  extend  Helpers
  include Helpers

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
    @corpus    = CorpusRepository.find(params[:corpus_id].to_i)
    @document  = @corpus.documents[params[:id].to_i]
    @tfidf     = tfidf(@document, @corpus)
    @scores    = scores(@tfidf)
    @sentences = sentences(@document, @scores)

    slim :"documents/show"
  end

  delete '/corpuses/:corpus_id/documents/:id' do
    @corpus   = CorpusRepository.find(params[:corpus_id].to_i)
    @document = @corpus.documents[params[:id].to_i]
    @corpus.documents.delete(@document)

    redirect "/corpuses/#{params[:corpus_id]}"
  end

  seed! if CorpusRepository.all.compact.size.zero?

  run! if app_file == $0
end
