require 'json'
require_relative 'data_handler'

data = JSON.parse(File.read('test_data\media_search.json'))

#puts data['data']

puts get_locations(data)