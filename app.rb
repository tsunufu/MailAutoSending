require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'

require './models'

use Rack::Session::Cookie



get '/' do
    @roulette = Groups.all.order('id desc')
    erb :index
end

get '/roulette/add' do
    erb :roulette_add
end

post '/roulette/add' do
    Groups.create(name: params[:name])
    redirect '/'
end


get '/info/:id' do
    @roulette = Groups.find(params[:id])
    content = Contents.where(group_id: params[:id])
     unless content
        content = nil
     else
         if content.class == "array"
            @contents = content.all.order('id desc')
         else
            @contents = content.all.order('id desc')
         end
     end
    array = Contents.all
    @random = array.shuffle[0..9]
     erb :roulette
end


get '/contents/add/:id' do
    @roulette = Groups.find(params[:id])
    erb :contents_add
end



post '/contents/add/:id' do
    Contents.create(title: params[:name], group_id: params[:id])
    redirect '/info/' + params[:id]
end


get '/rundom/:id' do
    @roulette = Groups.find(params[:id])
    array = Contents.where(group_id: params[:id]).all
    @random = array.shuffle[0..9]
    sleep 5
    erb :rundom
end


get '/delete/:id' do
    Contents.find(params[:id]).destroy
    redirect '/'
end

get '/remove/:id' do
    Groups.find(params[:id]).destroy
    Contents.where(group_id: params[:id]).destroy_all
    redirect '/'
end