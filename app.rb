require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require './models'

get '/' do
    @contents = Contribution.all
    erb :index
end

get '/delete/:id' do
    @content = Contribution.destroy(params[:id]) 
    redirect '/'
end

get '/edit/:id' do
   @content = Contribution.find(params[:id])
   erb :edit
end

post '/renew/:id' do
    @content = Contribution.find(params[:id]) 
    @content.update({
       title: params[:title],
       body: params[:body]
    })
    redirect '/'
end

post '/new' do
   Contribution.create({
       title: params[:title],
       body: params[:body]
   }) 
   redirect '/'
end