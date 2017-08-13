require 'sinatra'
require 'instagram'

CLIENT_ID 		= "7c84da3caa784119b3550d2370a5c2da"
CLIENT_SECRET 	= "cab9868fa7374c68bf32966ce93df1be"
CALLBACK_URL 	= "https://gramworthy.herokuapp.com/oauth/callback"

enable :sessions

@token

get '/' do
	redirect '/index.html' # This needs to be changed back to root '/' later
end

get '/locations' do
  [200, {
	"data": [{

		"location": {
			      "latitude": -41.307489,
			"longitude": 174.777088,
			"name": "Newtown",
			"frequency": 1
		}
	},
	{
		"location": {
			"latitude": -41.310967,
			"longitude": 174.779663,
			"name": "Newtown",
			"frequency": 2
		}
	},
	{
		"location": {
			"latitude": -41.303641,
			"longitude": 174.774985,
			"name": "Mount Cook",
			"frequency": 3
		}
	}
	]
}.to_json]

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
  puts response.inspect
  puts response.access_token
  @token = response.access_token
  #session[:access_token] = response.access_token
  redirect '/index.html'
end


##-----------------------------------------------
## Instagram API Oauth2 connection
##-----------------------------------------------

get "/media_search" do
  puts @token
  client = Instagram.client(:access_token => @token)
  [200,  client.media_search("37.7808851","-122.3948632")]
end

