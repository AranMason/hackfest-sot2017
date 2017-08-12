
#Finds the most common location amoung a given dataset. 
#image_set - the set of image data to search
#points the top n results to return
def freq_search(image_set, points)

	frequency = Hash.new
	
	#Get frequency of locations in the data.
	
	image_set.data.each do |image|
		loc = image.location
		#Skip images that are not attached to a location
		if loc != nil
			loc_freq = frequency.fetch(loc, {1}){|i| i + 1 }
			
			frequency[loc] = loc_freq
		end
	end
	
	#Sort the locations

	frequency = frequency.sort_by(|image, freq| freq)
	
	
	#Cull down to the given number of points. If it is not a value number of points, will default to 3.
	if points < 1 or points == nil
		points = 3
	end
	
	
	
	#https://stackoverflow.com/questions/4339553/sort-hash-by-key-return-hash-in-ruby
	return frequency
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