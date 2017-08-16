require 'json'
require 'set'

class DataHandler

	def test(data)
		data.to_json
	end

	#Finds the most common location amoung a given dataset. 
	#image_set - the set of image data to search
	#points the top n results to return
	def mostFreq(frequency, points)
		
		#Sort the locations
		freq = frequency.sort_by(){|image, freq| freq}.reverse[0,points]
		results = Hash[freq]
		
		results
	end

	# Return a set of location objects
	def get_locations(image_set)

	  locations = Set.new
	  frequency = Hash.new
		
		#Get frequency of locations in the data.
		
		image_set['data'].each do |image|
			loc = image['location']
			#Skip images that are not attached to a location
			if loc != nil
				#Increments the frequency count of that location by one.
				loc_freq = frequency.fetch(loc['name'], 0)
				frequency[loc['name']] = loc_freq+1
				locations << loc			 
			end
		end
		
		most_freq = mostFreq(frequency, 3)
		
		most_freq_loc = Array.new

		# Get the location data for the most frequent locations
		
		most_freq.each do |key, value|
			puts key
			puts value
			locations.each do |loc|
				if loc['name'] == key
					loc['frequency'] = value
					most_freq_loc << loc
				end
			end
			puts '---'
		end
		
		most_freq_loc
	end



	# Return locational data for the most popular locations in a given radius
	def pop_locations(image_set, points)

	  freq_results = freq_search image_set, points

	end

	#Finds all images in the given set that contains the given #tags
	def hashtag_filter(images, tags)
		results = Array.new
		
		images.data.each do |photo|
			photo.tags.each do |tag|
				
			end
		end
		
		for image in data.data
			for tag in tags
				if image.tags.includes? tag
					results << image
				end
			end
		end
		
		return results
	end
	### Testing

	test_data = JSON.parse('{
		"data": [{
			"distance": 41.741369194629698,
			"type": "image",
			"users_in_photo": [],
			"filter": "Earlybird",
			"tags": [],
			"comments": {
				"count": 2
			},
			"caption": null,
			"likes": {
				"count": 1
			},
			"link": "http://instagr.am/p/BQEEq/",
			"user": {
				"username": "mahaface",
				"profile_picture": "http://distillery.s3.amazonaws.com/profiles/profile_1329896_75sq_1294131373.jpg",
				"id": "1329896"
			},
			"created_time": "1296251679",
			"images": {
				"low_resolution": {
					"url": "http://distillery.s3.amazonaws.com/media/2011/01/28/0cc4f24f25654b1c8d655835c58b850a_6.jpg",
					"width": 306,
					"height": 306
				},
				"thumbnail": {
					"url": "http://distillery.s3.amazonaws.com/media/2011/01/28/0cc4f24f25654b1c8d655835c58b850a_5.jpg",
					"width": 150,
					"height": 150
				},
				"standard_resolution": {
					"url": "http://distillery.s3.amazonaws.com/media/2011/01/28/0cc4f24f25654b1c8d655835c58b850a_7.jpg",
					"width": 612,
					"height": 612
				}
			},
			"id": "20988202",
			"location": null
		},
		{
			"distance": 41.741369194629698,
			"type": "video",
			"videos": {
				"low_resolution": {
					"url": "http://distilleryvesper9-13.ak.instagram.com/090d06dad9cd11e2aa0912313817975d_102.mp4",
					"width": 480,
					"height": 480
				},
				"standard_resolution": {
					"url": "http://distilleryvesper9-13.ak.instagram.com/090d06dad9cd11e2aa0912313817975d_101.mp4",
					"width": 640,
					"height": 640
				},
			"users_in_photo": null,
			"filter": "Vesper",
			"tags": [],
			"comments": {
				"count": 2
			},
			"caption": null,
			"likes": {
				"count": 1
			},
			"link": "http://instagr.am/p/D/",
			"user": {
				"username": "kevin",
				"full_name": "Kevin S",
				"profile_picture": "...",
				"id": "3"
			},
			"created_time": "1279340983",
			"images": {
				"low_resolution": {
					"url": "http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_6.jpg",
					"width": 306,
					"height": 306
				},
				"thumbnail": {
					"url": "http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_5.jpg",
					"width": 150,
					"height": 150
				},
				"standard_resolution": {
					"url": "http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_7.jpg",
					"width": 612,
					"height": 612
				}
			},
			"id": "3",
			"location": null
		}
	}]}')

	 
	loc = get_locations(test_data)
	loc.each { |location| puts location }
	
end
