require 'sinatra'
require 'instagram'

CLIENT_ID 		= "7c84da3caa784119b3550d2370a5c2da"
CLIENT_SECRET 	= "cab9868fa7374c68bf32966ce93df1be"
CALLBACK_URL 	= "https://gramworthy.herokuapp.com/oauth/callback"

enable :sessions
get '/' do
	redirect '/index.html'
end

get '/locations' do
  [200, {
	"data": [{

		"location": {
			"latitude": -41.2818,
			"longitude": 174.7689,
			"name": "Kelburn",
			"rank": 1
		}
	},
	{
		"location": {
			"latitude": -41.2721,
			"longitude": 174.7704,
			"name": "Tinakori Hill",
			"rank": 2,
			"frequency": 1
		}
	},
	{
		"location": {
			"latitude": -41.2773,
			"longitude": 174.7784,
			"name": "Thorndon",
			"rank": 3
		}
	}
	]
}.to_json]

end


##-----------------------------------------------
## Instagram API Oauth2 connection
##-----------------------------------------------

Instagram.configure do |config|
  config.client_id = CLIENT_ID
  config.client_secret = CLIENT_SECRET
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end

get "/oauth/connect" do
   redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/nav"
end


##-----------------------------------------------
## Instagram API Oauth2 connection
##-----------------------------------------------

get "/media_search" do
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Get a list of media close to a given latitude and longitude</h1>"

  media_search(client.media_search("-41.2770666667","174.7784"))

  #for media_item in client.media_search("-41.2770666667","-122.3948632")
  #  html << "<img src='#{media_item.images.thumbnail.url}'>"
  #end
  #html
end
