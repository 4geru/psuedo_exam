require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require './models'

before do
    @my_name = 'しげる'
    @categories = Category.all
 end

get '/' do
    @contents = Contribution.all
    @categories = Category.all
    erb :index
end

get '/category/:category_id' do
    @contents = Contribution.where(:category_id => params[:category_id])
    @categories = Category.all
    erb :index
end

get '/delete/:id' do
    @content = Contribution.destroy(params[:id]) 
    redirect '/'
end

get '/edit/:id' do
    @content = Contribution.find(params[:id])
    @categories = Category.all
    erb :edit
end

post '/renew/:id' do
    @content = Contribution.find(params[:id]) 
    @content.update({
       title: params[:title],
       body: params[:body],
       category_id: params[:category]

    })
    redirect '/'
end

post '/new' do
   Contribution.create({
       title: params[:title],
       body: params[:body],
       category_id: params[:category]
   }) 
   redirect '/'
end