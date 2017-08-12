require 'sinatra'

get '/' do
  [200, {
	"data": [{
		
		"location": {
			"latitude": -41.2818,
			"longitude": 174.7689,
			"name": "Kelburn",
			"id": 1
		}
	},
	{
		"location": {
			"latitude": -41.2721,
			"longitude": 174.7704,
			"name": "Tinakori Hill",
			"id": 2
		}
	},
	{
		"location": {
			"latitude": -41.2773,
			"longitude": 174.7784,
			"name": "Thorndon",
			"id": 3
		}
	},
	{
		"location": {
			"latitude": -41.2773,
			"longitude": 174.7784,
			"name": "Thorndon",
			"id": 3
		}
	}
	]
}.to_json]

end

=begin

get "/media_search" do
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Get a list of media close to a given latitude and longitude</h1>"
  for media_item in client.media_search("37.7808851","-122.3948632")
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  html
end

Instagram.configure do |config|
  config.client_id = "YOUR_CLIENT_ID"
  config.client_secret = "YOUR_CLIENT_SECRET"
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

=end
