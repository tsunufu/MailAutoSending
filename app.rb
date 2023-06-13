require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require 'mail'

require './models'



use Rack::Session::Cookie,
    secret: 'set_your_secret_key'
    
    
options = {
  :address  => "smtp.gmail.com",
  :port   => 587,
  :domain  => "gmail.com",
  :user_name  => "TestRyosukeTsunufu@gmail.com",
  :password  => "iezmphqqlzwpfvhd",
  :authentication => 'plain',
  :enable_starttls_auto => true  
}


Mail.defaults do
  delivery_method :smtp, options
end


get '/' do
    erb :index
end

post '/send' do
    
    adress = params[:mailadress]
    title  = params[:title]
    body   = params[:body]
    
    begin    
        @mail = Mail.deliver do
            from    "TestRyosukeTsunufu@gmail.com"
            to      adress
            subject title
            body    body
        end
        @mail.deliver!
    rescue => e
        puts "エラーが発生しました：#{e.message}"
        redirect '/error'
    end
    
    # mail.delivery_method(:smtp,
    #   authentication: nil,
    #   user_name:      "websmailtest400@gmail.com",
    #   password:       "ktest111"
    # )
    
    # mail.delivery_method(:smtp,
    #   user_name:      "websmailtest400@gmail.com",
    #   password:       "ktest111"
    # )
    
    # mail.delivery_method(:smtp,
    #   user_name:      "websmailtest400@gmail.com",
    #   password:       "ktest111",
    #   authentication: :login
    # )
  
   

    redirect '/' 
    
end

get '/error' do
    erb :error
end