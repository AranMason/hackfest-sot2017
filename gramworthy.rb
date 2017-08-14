require 'sinatra'
require 'instagram_api'
require_relative 'data_handler'

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
	puts '-----'
	puts params.inspect
   [200, get_locations(client.media_search(
	  :lat => params[:lat],
	  :lng => params[:long],
	  :distance => 5000
	)).to_json]

end

get '/locations/images' do
	[200, {
    
    "data": [
	
	
	{ 
          "images": {
                      "thumbnail": {
                                     "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=1",
                                    "width": 125,
                                    "height": 125
                                   }
                    },
          "location": {
                        "latitude": -41.2818,
		       "longitude": 174.7689,
		       "name": "Kelburn",
		       "frequency": 1
                      }
	  
        },
    
	
	
	
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=2",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=3",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=4",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=5",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=6",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=7",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=8",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=9",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=10",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=11",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=12",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=13",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=14",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=15",
                "width": 125,
                "height": 125
            }
		}
    },
	{ 
        "images": {
            "thumbnail": {
                "url": "https://loremflickr.com/125/125/coffee,wellington/all?i=16",
                "width": 125,
                "height": 125
            }
		}
    }]
}.to_json]

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

