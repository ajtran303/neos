require_relative 'near_earth_objects'
require_relative "astroid_table"

puts "________________________________________________________________________________________________________________________________"
puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
puts "Please enter a date in the following format YYYY-MM-DD."
print ">>"

date = gets.chomp
astroid_details = NearEarthObjects.find_neos_by_date(date)
astroid_list = astroid_details[:astroid_list]
total_number_of_astroids = astroid_details[:total_number_of_astroids]
largest_astroid = astroid_details[:biggest_astroid]

formated_date = DateTime.parse(date).strftime("%A %b %d, %Y")
puts "______________________________________________________________________________"
puts "On #{formated_date}, there were #{total_number_of_astroids} objects that almost collided with the earth."
puts "The largest of these was #{largest_astroid} ft. in diameter."
puts "\nHere is a list of objects with details:"

AstroidTable.create_table(astroid_list)
