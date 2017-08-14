require 'sinatra'
require 'instagram_api'
require_relative 'data_handler'
require 'net/http'
require 'uri'

#CLIENT_ID 		= "7c84da3caa784119b3550d2370a5c2da"
#CLIENT_SECRET 	= "cab9868fa7374c68bf32966ce93df1be"
#CALLBACK_URL 	= "https://gramworthy.herokuapp.com/oauth/callback"

client = Instagram.client(
	  :client_id     => '7c84da3caa784119b3550d2370a5c2da',
	  :client_secret => 'cab9868fa7374c68bf32966ce93df1be',
	  :callback_url  => 'https://gramworthy.herokuapp.com/callback'
	)


enable :sessions

@token

get '/' do
	redirect '/auth' # This needs to be changed back to root '/' later
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
	
	req = Net::HTTP::Get.new(uri)
	
	res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme== 'https') do |http|
		request = Net::HTTP::Get.new uri
		
		responce = http.request request
		
		[200. responce.inspect]
	
	end

end

##-----------------------------------------------
## Instagram API Oauth2 connection
##-----------------------------------------------

get '/auth' do
	redirect client.authorize_url + "&scope=public_content"
end

get "/callback" do
	client.get_access_token(params[:code])
	redirect '/index.html'
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

