
#Finds the most common location amoung a given dataset. 
#image_set - the set of image data to search
#points the top n results to return
def freq_search(frequency, points)
	
	#Sort the locations

	frequency = frequency.sort_by(){|image, freq| freq}.reverse
	
	#Cull down to the given number of points. If it is not a value number of points, will default to 3.
	if points < 1 or points == nil
		points = 3
	end
	
	results = Hash.new
	
	points = [points, frequency.length].min
	
	points.times do |i|
		key = frequency.keys[i]
		results[key] = (frequency[key])
	end
	
	
	#https://stackoverflow.com/questions/4339553/sort-hash-by-key-return-hash-in-ruby
	return results
end

# Return a set of location objects
def get_locations(image_set)

  locations = Set.new
  frequency = Hash.new
	
	#Get frequency of locations in the data.
	
	image_set["data"].each do |image|
		loc = image["location"]
		#Skip images that are not attached to a location
		if loc != nil
			#INcrements the frequency count of that location by one.
			frequency[loc["name"]] = frequency.fetch(loc["name"], 1){|i| i + 1 }
			 locations << loc			 
		end
	end

  locations

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
