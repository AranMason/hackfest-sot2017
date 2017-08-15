require 'sinatra'
require 'instagram'
require_relative 'data_handler'
require 'net/http'
require 'uri'


##-----------------------------------------------
## Static Variables
##-----------------------------------------------
CLIENT_ID 		= "7c84da3caa784119b3550d2370a5c2da"
CLIENT_SECRET 	= "cab9868fa7374c68bf32966ce93df1be"
CALLBACK_URL 	= "https://localhost:4567/callback" #"https://gramworthy.herokuapp.com/oauth/callback"

enable :sessions

@token = ""

##-----------------------------------------------
## Instagram API Setup
##-----------------------------------------------

Instagram.configure do |config|
  config.client_id = CLIENT_ID
  config.client_secret = CLIENT_SECRET
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end

##-----------------------------------------------
## Webpage Serving
##-----------------------------------------------

get '/' do
	redirect '/auth' # This needs to be changed back to root '/' later
end

##-----------------------------------------------
## Instagram API Oauth2 connection
##-----------------------------------------------

get '/auth' do
	redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/callback" do
	response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
	session[:access_token] = response.access_token
	puts "Debug Data"
	puts responce.inspect
	puts response.access_token.inspect
	puts session.inspect
	redirect "/test"
end

get '/test' do
	[200, test(client.media_search(
	
	#"latitude":-44.633031728245,"longitude":168.89599135605,
	  :lat => "-41.3139",
	  :lng => "174.7694",
	  :distance => 5000
	))]
end

##-----------------------------------------------
## Instagram API Oauth2 connection
##-----------------------------------------------

get "/media_search" do
  puts @token
  client = client.user
  [200,  client]
end

get '/locations' do
   [200, get_locations(client.media_search(
	  :lat => params[:lat],
	  :lng => params[:long],
	  :distance => 5000
	)).to_json]

end

get '/locations/:id' do |id|
	token = client.get_access_token
	#214818324
	uri = URI("https://api.instagram.com/v1/locations/#{id}/media/recent?access_token=#{token}")
	
	#req = Net::HTTP::Get.new(uri)
	
	res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme== 'https') do |http|
		request = Net::HTTP::Get.new uri
		
		responce = http.request request
		
		[200. responce.inspect]
	
	end

end

