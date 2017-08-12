
#Finds the most common location amoung a given dataset
def feq_search(data)


	#h.sort.to_h
	#https://stackoverflow.com/questions/4339553/sort-hash-by-key-return-hash-in-ruby
	return nil
end

#Finds all images in the given set that contains the given #tags
def hashtag_filter(data, tags)
	results = Array.new
	for image in data
		for tag in tags
			if image.tags.includes? tag
				results << image
			end
		end
	end
	
	return results
end